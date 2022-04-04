import 'dart:convert';

import 'package:http/http.dart';
import 'package:world_time_app/model/city.dart';

class TimeZones{

  List timeZones_cleaned = [];

  Future<List> availableTimeZones() async {

    try{

      final response = await get(Uri.parse("https://www.timeapi.io/api/TimeZone/AvailableTimeZones"));
      final jsonData = jsonDecode(response.body);
      String jsonDataCleaned = jsonData.toString().replaceAll("[", ""); //removes square braces from the list passed
      jsonDataCleaned = jsonDataCleaned.toString().replaceAll("]", ""); //removes square braces from the list passed
      List timeZones = jsonDataCleaned.toString().split(",");

      for(var each_city in timeZones){
        timeZones_cleaned.add(each_city);
      }

    }catch(err){
      print("Time zone error is ${err.toString()}");
    }
    return timeZones_cleaned;
  }

}