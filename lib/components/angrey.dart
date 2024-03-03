import 'package:flutter/material.dart';

class AngerList extends StatefulWidget {
  const AngerList({super.key});

  @override
  State<AngerList> createState() => _AngerListState();
}

class _AngerListState extends State<AngerList> {
  List<bool> isChecked = [false, false, false, false];
  List<String> anger = ["anger1", "anger2", "anger3", "anger4"];
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
                      color: Colors.transparent,
                      child: Image.asset("assets/images/anger.png"),
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          anger[index],
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
