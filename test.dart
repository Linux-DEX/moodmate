
main() {
  // DateTime now = DateTime.now();
  // // DateTime previousDay = now.subtract(Duration(days: 1));
  // String today = DateFormat('EEEE').format(now).toLowerCase();
  // print(today);

  Map<String, Map<String, int>> prevMoodValue = {
    "sunday": {
      "depress": 3,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "monday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 4,
    },
    "tuesday": {
      "depress": 0,
      "stress": 2,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "wednesday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "thursday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 1,
      "relax": 0,
      "happy": 0,
    },
    "friday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 5,
    },
    "saturday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 5,
      "happy": 0,
    }
  };

  Map<String, String> prevDayMood = {
    "sunday": "depress",
    "monday": "happy",
    "tuesday": "stress",
    "wednesday": "depress",
    "thursday": "sad",
    "friday": "happy",
    "saturday": "relax"
  };

  // using forEach method
  // prevDayMood.forEach((day, mood) {
  //   print('$day: $mood');
  // });

  // using for-in method
  for (var entry in prevDayMood.entries) {
    var day = entry.key;
    var mood = entry.value;
    print(prevMoodValue[day]![mood]);
  }
}
