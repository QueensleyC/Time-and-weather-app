import 'dart:convert';

import 'package:http/http.dart';
import 'package:world_time_app/model/city.dart';

class TimeZones{

  List timeZones = [];

  Future<List> availableTimeZones() async {

    try{

      final response = await get(Uri.parse("https://www.timeapi.io/api/TimeZone/AvailableTimeZones"));
      final jsonData = jsonDecode(response.body);
      String jsonDataCleaned = jsonData.toString().replaceAll("[", "");
      jsonDataCleaned = jsonDataCleaned.toString().replaceAll("]", "");
      List first_timeZones = jsonDataCleaned.toString().split(",");

      for(var each_city in first_timeZones){
        timeZones.add(each_city);
      }

    }catch(err){
      print("Time zone error is ${err.toString()}");
    }
    return timeZones;
  }

}