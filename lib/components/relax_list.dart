import 'package:flutter/material.dart';

class RelaxList extends StatefulWidget {
  const RelaxList({super.key});

  @override
  State<RelaxList> createState() => _RelaxListState();
}

class _RelaxListState extends State<RelaxList> {
  List<bool> isChecked = [false, false, false, false ,false];
  List<String> relax = [
    "Deep breaths",
    "Light a candle",
    "Read a book",
    "Stretch routine",
    "Enjoy nature"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/breath.png",
    "assets/images/candle.png", 
    "assets/images/book.png", 
    "assets/images/stretchroutine.png",
    "assets/images/nature.png"
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
                            relax[index],
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
