import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/Model/user.dart';
import 'package:moodmate/Providers/user_provider.dart';
import 'package:moodmate/resources/firestore_methods.dart';
import 'package:moodmate/reusable_widgets/like_animation.dart';
import 'package:moodmate/screens/comments_screen.dart';
import 'package:moodmate/utils.dart';
import 'package:provider/provider.dart';
class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key,required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating =false;
  int commentLen=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  void getComments()async
  {
    try{
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
    commentLen = snap.docs.length;
    }
    catch (e)
    {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Column(children: [
        //HEADER
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16
          ).copyWith(right: 0),
          child: Row(children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                widget.snap['profImage']
              ),
            ),
            Expanded(child: Padding(padding: EdgeInsets.only(left: 8),
            child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(widget.snap['username'])
            ],),)),
            IconButton(onPressed: (){
              showDialog(context: context, builder: (context)=>Dialog(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: 16
                  ),
                  shrinkWrap: true,
                  children: [
                    'Delete',
                  ].map((e) => InkWell(
                    onTap: ()async {
                      FirestoreMethods().deletePost(widget.snap['postId']);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                      child: Text(e),
                    ),
                  )).toList(),
                ),
              ));
            }, icon: Icon(Icons.more_vert))
          ],),
        )
      ,
      //IMAGE
      GestureDetector(
        onDoubleTap:()async{
          await FirestoreMethods().likePost(
            widget.snap['postId'],
            user.uid,
            widget.snap['likes']
          );
          setState(() {
            isLikeAnimating=true;
          });
        } ,
        child: Stack(
          alignment: Alignment.center,
          children:[ SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            child: Image.network(widget.snap['postUrl'],
            fit: BoxFit.cover,),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: isLikeAnimating?1:0,
            child: LikeAnimation(child: Icon(Icons.favorite,color: Colors.white, size: 100,),
             isAnimating: isLikeAnimating,
             duration: Duration(milliseconds: 400),
             onEnd: (){
              setState(() {
                isLikeAnimating=false;
              });
             },),
          )
        ]),
      ),
      //LIKE COMMENT SECTION
      Row(
        children: [
          LikeAnimation(
            isAnimating: widget.snap['likes'].contains(user.uid),
            smallLike: true,
            child: IconButton(onPressed: ()async{
              await FirestoreMethods().likePost(
            widget.snap['postId'],
            user.uid,
            widget.snap['likes']
          );
            },
             icon: widget.snap['likes'].contains(user.uid)? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline_rounded,color: Colors.black,)),
          ),
           IconButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentsScreen(
            snap: widget.snap,
           ))),
           icon: Icon(Icons.comment_rounded,)),
           IconButton(onPressed: (){},
           icon: Icon(Icons.send_rounded,)),
           Expanded(child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.bookmark_border_rounded),
              onPressed: (){},
            ),
           ))
        ],
      ),
      //Description And Comments
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.snap['likes'].length}likes'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 8
              ),
              child: RichText(text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                TextSpan(
                  text: widget.snap['username'],
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: ' ${widget.snap['description']}',
                )
              ]),),
            )
            ,
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('View all ${commentLen} comments'),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd().format(widget.snap['datePublished'].toDate())
                )),
          ],
        ),
      )
      ],),
    );
  }
}
