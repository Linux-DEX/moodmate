import 'package:flutter/material.dart';

class HappyList extends StatefulWidget {
  const HappyList({super.key});

  @override
  State<HappyList> createState() => _HappyListState();
}

class _HappyListState extends State<HappyList> {
  List<bool> isChecked = [false, false, false, false];
  List<String> happy = ["happy1", "happy2", "happy3", "happy4"];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
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
                      width: 55.0,
                      height: 55.0,
                      color: Colors.blueAccent,
                      child: Image.asset("assets/images/Happy.png"),
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          happy[index],
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(workout[index]),
                      ],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
  }
}
