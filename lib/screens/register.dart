import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreedState createState() =>_RegisterScreedState();
  }
  
  class _RegisterScreedState extends State<RegisterScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // pour le formulaire
    String firstName = ''; 
    String name = ''; 
    String city = ''; 
    String email = '';
    String password = '';
    String errorValidation = '';
    Widget build(BuildContext context){
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text('Register'),
                SizedBox(height:10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value){
                          setState(() {
                            name = value;
                          });
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Fist name',
                          hintText: 'Enter your first name'
                      ),
                      ),
                      
                      TextFormField(
                        onSaved: (value){
                          setState(() {
                            firstName = value;
                          });
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name'
                      ),
                      ),
                      TextFormField(
                        onSaved: (value){
                          setState(() {
                            city = value;
                          });
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'City',
                          hintText: 'Enter your city'
                      ),
                      ),
                      TextFormField(
                        onSaved: (value){
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Empty';
                          }else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0_9]+\.[a-z]+$").hasMatch(value) ){
                          return 'Invalid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email'
                      ),
                      ),
                      TextFormField(
                        onSaved: (value){
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Empty';
                          }else if(value.length < 8){
                            return 'Password to short';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password'
                      ),
                      ),
                      SizedBox(height:10),
                      Text(errorValidation),
                      SizedBox(height:10),
                      ElevatedButton(
                        onPressed: () async {
                          if(_formKey.currentState.validate()){ // regarde si la valeur dans les champ est correct. fait appel au parametre validation des champs
                            _formKey.currentState.save();// récupere la valeur des champs States
                            try{
                              UserCredential userCredential = 
                              await firebaseAuth.createUserWithEmailAndPassword(
                                email: email, password: password); // cette fonction procède à l'enregistrement sur firebase
                              if (userCredential.user != null){
                                final docReference = firestore.collection('users');//crée une nouvel colection si elle n'éxiste pas. si elle existe elle ajoute la donné dans la bdd
                                docReference.add({
                                  'firstName' : firstName,
                                  'name' :name,
                                  'city' :city,
                                  'email' : userCredential.user.email
                                }).catchError((error){
                                  setState(() {
                                    errorValidation = 
                                      'Failed to add your credentials';
                                  });
                                });
                              }
                              print('Succeed to register');
                              Navigator.pushReplacementNamed(context, '/home');

                            }on FirebaseAuthException catch(error){
                              if(error.code == 'weak-password'){
                                setState(() {
                                  errorValidation= 'Password too weak';
                                });
                              }else if (error.code == 'email-already-in-use'){
                                setState(() {
                                  errorValidation = 'Email already used';
                                });
                              }
                            print(error);

                            }
                          }
                        },
                        child: Text('Submit'),
                        )


                  ],)),
              
              ],),
            ),
          ),),
      );
    }
}