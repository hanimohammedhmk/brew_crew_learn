import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = "";
  String passwd = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign in to Brew Crew'),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.yellow,
                    ),
                    label: const Text(
                      "Register",
                      style: TextStyle(color: Colors.yellow),
                    ))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              (val!.isEmpty || !(val.contains('@')))
                                  ? "Enter an Email"
                                  : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val!.length < 7
                                ? "Password length should be more than 6 characters"
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => passwd = val);
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, passwd);
                              if (result == null) {
                                setState(() {
                                  error = 'Invalid credentials !!';
                                  loading = false;
                                });
                              }
                              print(email);
                              print(passwd);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ))),
          );
  }
}
