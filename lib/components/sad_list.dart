import 'package:flutter/material.dart';

class SadList extends StatefulWidget {
  const SadList({super.key});

  @override
  State<SadList> createState() => _SadListState();
}

class _SadListState extends State<SadList> {
  List<bool> isChecked = [false, false, false, false];
  List<String> sad = ["sad1", "sad2", "sad3", "sad4"];
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
                      child: Image.asset("assets/images/sad.png"),
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sad[index],
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
