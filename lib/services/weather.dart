

import 'dart:convert';

import 'package:http/http.dart';

class WeatherData{

  double temp = 0;
  double wind = 0;
  int humidity = 0;
  double feelsLike = 0;

  String address = "https://api.openweathermap.org/data/2.5/weather?q="; //website address
  String apiKey = "&appid=9b01df4b5acd25c7492260ce6b2cbb9a&units=metric"; //api key. Generate your own api key from openweathermap.api

  weatherData(String cityName)async{

    try {
      final response = await get(Uri.parse("$address + $cityName + $apiKey")); //fetches weather data based on city selected
      final jsonData = jsonDecode(response.body); //converts the data to a json object
      print("Weather data is ${jsonData}");

      //Assigns values from json object to our variables
      temp = jsonData["main"]["temp"];
      feelsLike = jsonData["main"]["feels_like"];
      humidity = jsonData["main"]["humidity"];
      wind = jsonData["wind"]["speed"];
    } catch (err){
      print("Weather err is ${err.toString()}");
    }
  }

}