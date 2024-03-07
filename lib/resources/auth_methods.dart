
import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart" ;
import "package:moodmate/Model/user.dart"as model;
import "package:moodmate/resources/storage_methods.dart";

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(
      snap
    );
  }
  //sign up user
  Future<String> signUpUser({required String email,
  required String password,
  required String username,
  required String bio,
  required Uint8List file
  })
  async{
      String res= "Some Error Occured";
      try
      {
        if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty)
        {
          //Register user
          UserCredential cred= await  _auth.createUserWithEmailAndPassword(email: email, password: password);

          //Photo upload
          String photoUrl= await StorageMethods().uploadImageToStrorage('profilePics', file, false);

          model.User user =model.User(
            username:username,
            uid:cred.user!.uid,
            email:email,
            bio:bio,
            followers:[],
            following:[],
            photoUrl:photoUrl,
          );
          //add user to our database
          await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson()
            
          );
          res="success"; 

        }
      } on FirebaseAuthException catch(error){
        if(error.code=='invalid-email')
        {
          res='The email is not correct!';
        }
        else if(error.code=='weak-password')
        {
          res='Weak password!';
        }
        res= error.toString();
        return res;
      }
      catch(error)
      {
          res= error.toString();
      }
      return res;
  }
  Future<void> signOut() async{
    await _auth.signOut();
  }
}