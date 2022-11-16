import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica1/recording.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In',
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark(),
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,       
      ),
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/originals/8a/eb/76/8aeb760e1cba623527d931c2d1b0c2ac.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Sign in',style: TextStyle(fontSize: 30)),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
            elevation: 0,           
          ),
          body: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              decoration: new BoxDecoration(color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network('https://cdn-icons-png.flaticon.com/512/3039/3039555.png',width: 100,height: 100),
                  ),
                  SizedBox(height: 20),
                  Text('Music Finder',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(height: 50),
                  Center(              
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      icon: Image.network('https://cdn-icons-png.flaticon.com/512/300/300221.png',width: 20,height: 20,),
                      label: const Text('Sign in with Google'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
    
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) =>  {Navigator.pushNamed(context, 'recording'),
          FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
            'name': value.user!.displayName,
            'email': value.user!.email,
            'uid': value.user!.uid,
          }, SetOptions(merge: true))
        });
  }





}
