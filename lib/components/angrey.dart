import 'package:flutter/material.dart';

class AngerList extends StatefulWidget {
  const AngerList({super.key});

  @override
  State<AngerList> createState() => _AngerListState();
}

class _AngerListState extends State<AngerList> {
  List<bool> isChecked = [false, false, false, false, false];
  List<String> anger = [
    "Count to 10",
    "Squeeze a stress ball",
    "Punch a pillow",
    "Color in book",
    "Do jumping jacks"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp4",
  ];
  List<String> image = [
    "assets/images/count.png",
    "assets/images/squeezeball.png", 
    "assets/images/pillow.png", 
    "assets/images/colorbook.png",
    "assets/images/jumpingjack.png"
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
                            anger[index],
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
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
