import 'package:flutter/material.dart';

class HappyList extends StatefulWidget {
  const HappyList({super.key});

  @override
  State<HappyList> createState() => _HappyListState();
}

class _HappyListState extends State<HappyList> {
  List<bool> isChecked = [false,false, false, false, false];
  List<String> happy = [
    "Sing a song",
    "Call loved one",
    "Dance (alone!)",
    "Write down gratitude",
    "Do a happy dance"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/sing.png",
    "assets/images/callLoved.png", 
    "assets/images/dance.png", 
    "assets/images/gratitudewrite.png",
    "assets/images/happydance.png"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.transparent,
                        child: Image.asset(image[index]),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            happy[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(workout[index]),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Checkbox(
                        value: isChecked[index],
                        onChanged: (newValue) {
                          setState(() => isChecked[index] = !isChecked[index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
