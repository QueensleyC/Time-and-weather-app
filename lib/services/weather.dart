

import 'dart:convert';

import 'package:http/http.dart';

class WeatherData{

  double temp = 0;
  double wind = 0;
  int humidity = 0;
  double feels_like = 0;

  String address = "https://api.openweathermap.org/data/2.5/weather?q=";
  String api_key = "&appid=9b01df4b5acd25c7492260ce6b2cbb9a&units=metric";

  weatherData(String cityName)async{

    try {
      final response = await get(Uri.parse("$address + $cityName + $api_key"));
      final jsonData = jsonDecode(response.body);
      print("Weather data is ${jsonData}");

      temp = jsonData["main"]["temp"];
      feels_like = jsonData["main"]["feels_like"];
      humidity = jsonData["main"]["humidity"];
      wind = jsonData["wind"]["speed"];
    } catch (err){
      print("Weather err is ${err.toString()}");
    }
  }

}