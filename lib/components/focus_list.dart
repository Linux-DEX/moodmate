import 'package:flutter/material.dart';

class FocusList extends StatefulWidget {
  const FocusList({super.key});

  @override
  State<FocusList> createState() => FocusListState();
}

class FocusListState extends State<FocusList> {
  List<String> focus = ["focus1", "focus2", "focus3", "focus4"];
  // List<bool> isChecked = [false, false, false, false];
  // * another way of defining list of ischecked
  List<bool> isChecked = List.generate(4,(_) => false);
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
                      child: Image.asset("assets/images/Focus.png"),
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          focus[index],
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
                      onChanged: (bool? newValue) {
                        // * this is another way of checkbox
                        setState(() => isChecked[index] = newValue ?? false);
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
