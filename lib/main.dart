import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chat app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return ChatPage();
                  }),
                );
              },
              child: Text("Field"))
        ],
      )),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }),
                );
              },
              icon: Icon(Icons.close)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage();
            }),
          );
        },
      ),
    );
  }
}

class AddPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat post')),
      body: Center(
          child: ElevatedButton(
        child: Text('back'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )),
    );
  }
}
