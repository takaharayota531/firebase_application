import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/main.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage();
  // final User user;
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String messageText = "";
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final user = userState.user!;
    return Scaffold(
      appBar: AppBar(title: Text('チャット投稿画面')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "投稿メッセージ"),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (String value) {
                setState(() {
                  messageText = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('投稿'),
                onPressed: () async {
                  try {
                    //現在の日時
                    final date = DateTime.now().toLocal().toIso8601String();
                    final email = user.email;

                    await FirebaseFirestore.instance
                        .collection('posts')
                        .doc()
                        .set({
                      'text': messageText,
                      'email': email,
                      'date': date
                    });
                    Navigator.of(context).pop();
                  } catch (e) {}
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
