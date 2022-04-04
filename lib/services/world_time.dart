import 'dart:convert';
import 'package:http/http.dart';

class WorldTime {
  String location;
  String dateTime = "";
  String date = "";
  String time = "";
  String timeZone = "";
  String url;
  String dayOfWeek = "";
  bool isDst = true;
  bool isDay = true;

  WorldTime({required this.location, required this.url});

  late var jsonData;

  Future<void> getTime() async {
    try {
      final response = await get(Uri.parse(
          "https://www.timeapi.io/api/Time/current/zone?timeZone=$url"));
      jsonData = jsonDecode(response.body);
      print(jsonData);

      dateTime = jsonData['time'] + "  " + jsonData['date'];

      _customizeData();

      isDst = jsonData["dstActive"];

      time = jsonData['time'];
      timeZone = jsonData['timeZone'];
      print("date: $date");

      dayOfWeek = jsonData['dayOfWeek']; // gets the day of the week

      isDay = jsonData['hour'] > 6 && jsonData['hour'] < 18 ? true : false; //Tells us if it's day or night
    } catch (e) {
      print("Couldn't get url. \n $e");
    }
  }

  _customizeData() {
    switch (jsonData["month"]) {
      case 1:
        date = "January ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 2:
        date = "February ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 3:
        date = "March ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 4:
        date = "April ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 5:
        date = "May ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 6:
        date = "June ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 7:
        date = "July ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 8:
        date = "August ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 9:
        date = "September ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 10:
        date = "October ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 11:
        date = "November ${jsonData['day']}, ${jsonData['year']}";
        break;
      case 12:
        date = "December ${jsonData['day']}, ${jsonData['year']}";
        break;
    }
  }
}
