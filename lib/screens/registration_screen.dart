import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    kTextFieldDecoration('Enter your email', Colors.blueAccent),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kTextFieldDecoration(
                    'Enter your password', Colors.blueAccent),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  text: 'Register',
                  onPress: () async {
                    /*print(_email + ' ' + _password);*/
                    try {
                      setState(() {
                        _showSpinner = true;
                      });
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      if (newUser != null) {
                        Navigator.pushReplacementNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      setState(() {
                        _showSpinner = false;
                      });
                      print(e);
                    }
                  },
                  color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
