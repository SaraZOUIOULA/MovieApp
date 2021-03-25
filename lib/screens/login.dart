import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // pour le formulaire

  String email = '';
  String password = '';
  String errorValidation = '';

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Text('login'),
            SizedBox(height: 10),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Empty';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0_9]+\.[a-z]+$")
                            .hasMatch(value)) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email', hintText: 'Enter your email'),
                    ),
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Empty';
                        } else if (value.length < 8) {
                          return 'Password to short';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password'),
                    ),
                    SizedBox(height: 10),
                    Text(errorValidation),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // regarde si la valeur dans les champ est correct. fait appel au parametre validation des champs
                          _formKey.currentState
                              .save(); // récupere la valeur des champs States
                          try {
                            await firebaseAuth.signInWithEmailAndPassword(
                                email: email,
                                password:
                                    password); // cette fonction procède à l'enregistrement sur firebase
                            print('login success');
                            print(isLogged());
                            Navigator.pushReplacementNamed(context, '/home');
                          } on FirebaseAuthException catch (error) {
                            if (error.code == 'user-not-found') {
                              setState(() {
                                errorValidation = 'User not found';
                              });
                            } else if (error.code == 'wrong-password') {
                              setState(() {
                                errorValidation =
                                    'Email or password is invalid';
                              });
                            }
                            print(error);
                          }
                        }
                      },
                      child: Text('Sign In'),
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Text(
                '------If you are not registered tap on the button bellow------ '),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register');

              },child: Text('Register'),),
          
          ],
        ),
      ),
    ));
  }
}
