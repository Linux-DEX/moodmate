import 'package:flutter/material.dart';

class StressList extends StatefulWidget {
  const StressList({super.key});

  @override
  State<StressList> createState() => StressListState();
}

class StressListState extends State<StressList> {
  List<bool> isChecked = [false, false, false, false, false];
  // * another way of defining list of ischecked
  // List<bool> isChecked = List.generate(5, (_) => false);
  List<String> stress = [
    "5-min meditation",
    "Tidy your workspace",
    "Make a to-do list",
    "Listen calming music",
    "Do some cleaning"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/meditation.png",
    "assets/images/tidyworkspace.png", 
    "assets/images/todolist.png", 
    "assets/images/listenmusic.png",
    "assets/images/cleaning.png",
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
                            stress[index],
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
                        onChanged: (bool? newValue) {
                          // * this is another way of checkbox
                          setState(() => {
                                isChecked[index] = newValue ?? false,
                                // print("focus clicked"),
                                // print(isChecked[index].toString() +
                                //     " " +
                                //     index.toString())
                              });
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
