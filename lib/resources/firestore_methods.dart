

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:moodmate/Model/post.dart';
import 'package:moodmate/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  Future<String> uploadPost(String description,Uint8List file,String uid,String username,String profImage)async
  {
    String res ="some error occured";
    try{
      String photoUrl =await StorageMethods().uploadImageToStrorage('posts', file, true);
      String postId =const Uuid().v1(); 
      Post post = Post(description: description,
       uid: uid, username: username,
        postId:postId , 
        datePublished: DateTime.now(), 
        postUrl: photoUrl,
         profImage: profImage,
         likes: [],
        );
        _firestore.collection('posts').doc(postId).set(post.toJson());
        res="success";
    }catch(e)
    {
      res = e.toString();
    }
    return res;
  }
  Future<void> likePost(String postId,String uid,List likes)async{
    try
    {
      if(likes.contains(uid))
      {
        await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid]),
        });
      }
      else
      {
        await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid]),
        });
      }
    }
    catch(e)
    {

    }
  }
  Future<void> postComment(String postId,String text,String uid,String name,String profilePic)async
  {
    try
    {
      if(text.isNotEmpty)
      {
        String commentId=Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic':profilePic,
          'name':name,
          'uid':uid,
          'text':text,
          'commentId':commentId,
          'datePublished':DateTime.now(),
        });
        print('Posted Comment');
      }
      else
      {
        print("Empty Text");
      }
    }
    catch(e)
    {
      print(e.toString());
    }

  }
  Future<void> deletePost(String postId)async
  {
    try
    {
       await _firestore.collection('posts').doc(postId).delete();
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future<void> followUser(
    String uid,
    String followId
  )async
  {
    try
    {
      DocumentSnapshot snap=await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if(following.contains(followId))
      {
        await _firestore.collection('users').doc(followId).update({
          'followers':FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayRemove([followId])
        });
      }
      else
      {
        await _firestore.collection('users').doc(followId).update({
          'followers':FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following':FieldValue.arrayUnion([followId])
        });
      }
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}