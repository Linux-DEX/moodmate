import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:moodmate/main.dart';
import 'package:moodmate/screens/profile_screen.dart';
import 'package:moodmate/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search for a user'
          ),
          onFieldSubmitted: (String _){
            setState(() {
              isShowUsers=true;
            });
          },
        ),
      ),
      body:isShowUsers? FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').where('username',isGreaterThanOrEqualTo: searchController.text).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid']))),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['photoUrl']
                    ),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]['username']),
                ),
              );
            });
        },
      ):FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
         builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return MasonryGridView.count(
            crossAxisCount: 3,
            itemCount:(snapshot.data! as dynamic).docs.length,
            itemBuilder: (context,index)=>Image.network(
              (snapshot.data! as dynamic).docs[index]['postUrl']
              
            ),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            
          );
         })
      
    );
  }
}
