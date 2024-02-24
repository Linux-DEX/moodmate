import 'package:flutter/material.dart';

class FriendsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 2, 17, 2),
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          child: InkWell(
            onTap: () {
              print("friend");
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48),
                            // child: Image.asset("assets/images/Calm.png"),
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://res.cloudinary.com/demo/image/facebook/65646572251.jpg"),
                              ),
                          ),
                        ),
                        SizedBox(width: widthScreen * 0.2),
                        Column(
                          children: [
                            Text(
                              "USER NAME",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "Mindfulness",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "Screen time",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "Gym",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
