import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Firebase Auyh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 360,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                controller: emailTextController,
              ),
            ),
            SizedBox(
              width: 360,
              child: TextFormField(
                obscureText: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an password';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'password',
                ),
                controller: passwordTextController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      size: 30,
                    ),
                    Text(
                      'Sign up with Email',
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.red[400],
                padding: EdgeInsets.all(10),
                onPressed: () {
                  signUpWithMail();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signUpWithMail() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Success sign up'),
            );
          });
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }
}
