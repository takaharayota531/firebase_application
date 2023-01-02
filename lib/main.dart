import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import './postpage.dart';
import 'chatpage.dart';
import 'package:provider/provider.dart';

class UserState extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  //ユーザの情報を管理するデータ
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: MaterialApp(
        title: "chat app",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String infoText = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    //ユーザー情報をうけとる
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "mail address"),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "password"),
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  child: Text(infoText),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("ユーザ登録"),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result =
                            await auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        //ユーザー情報を更新
                        userState.setUser(result.user!);

                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage();
                          }),
                        );
                      } catch (e) {
                        setState(() {
                          infoText = "failed:${e.toString()}";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    child: Text("login"),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        userState.setUser(result.user!);
                        //ログインに成功した場合そのままチャット画面に遷移、ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage();
                          }),
                        );
                      } catch (e) {
                        setState(() {
                          infoText = "failed:${e.toString()}";
                        });
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
