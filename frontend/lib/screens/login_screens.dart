import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';
import 'home_screens.dart';
import 'register_screens.dart';

class LoginScreens extends StatefulWidget {
  static const routeName = '/login-screens';
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _password;

  void _loginNow() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    bool islogin = await Provider.of<PostState>(context, listen: false)
        .loginNow(_username, _password);
    if (!islogin) {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Somthing is Wrong!Try Again"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login To Code"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                TextFormField(
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return 'Enter your Username';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _username = v!;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return 'Enter your Password';
                    }

                    return null;
                  },
                  onSaved: (v) {
                    _password = v!;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _loginNow();
                      },
                      child: Text("Login"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreens.routeName);
                      },
                      child: Text("Register Now"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}