import 'package:chat_app/firebase/fb_auth_controller.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with Helpers {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';

  void _supmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      _submitAuthForm(context,
          email: _email.trim(),
          password: _password.trim(),
          username: _username.trim(),
          isLogin: _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                      decoration:
                          const InputDecoration(labelText: 'Email Address'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value!,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                      ),
                    TextFormField(
                      obscureText: true,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Please enter at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _supmit();
                        setState(() {
                          if(!_isLogin)
                          _isLogin = true;
                        });
                      } ,
                      child: Text((_isLogin) ? 'Login' : 'Sign Up'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          minimumSize: Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.pink),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text((_isLogin)
                          ? 'Create New Account'
                          : 'I already have an account'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitAuthForm(BuildContext context,
      {required String email,
      required String password,
      required String username,
      bool? isLogin}) async {
    if (isLogin!) {
      bool state = await FbAuthController().signIn(context,
          username: username, email: email, password: password);
      if (state) {
        Navigator.pushReplacementNamed(context, '/chat_screen');
      }
    } else {
      await FbAuthController().createAccount(context,
          email: email, password: password, username: username);
    }
  }
}
