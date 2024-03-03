// ? to store the data when ever the page is changed we can use shared_preference package. or directly we can save the data in firebase 
import 'package:flutter/material.dart';

class Depress extends StatefulWidget {
  const Depress({super.key});

  @override
  State<Depress> createState() => _DepressState();
}

class _DepressState extends State<Depress> {
  List<bool> isChecked = [false, false, false, false];
  List<String> depress = ["depress1", "depress2", "depress3", "depress4"];
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
                      child: Image.asset("assets/images/depress.png"),
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          depress[index],
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
