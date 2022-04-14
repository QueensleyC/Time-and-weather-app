

import 'dart:convert';

import 'package:http/http.dart';

class WeatherData{

  double temp = 0;
  double wind = 0;
  int humidity = 0;
  double feelsLike = 0;

  String address = "https://api.openweathermap.org/data/2.5/weather?q="; //website address

  //NOTE: make sure to use your OWN apikey, you can make a free account on openweathermap.api
  String apiKey = "&appid={ENTER YOUR API KEY HERE}&units=metric";

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