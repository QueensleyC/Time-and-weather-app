import 'package:flutter/material.dart';
import 'package:world_time_app/services/time_zones.dart';
import 'package:world_time_app/services/weather.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "Loading...";

  void getData() async {

    WorldTime data = WorldTime(
        location: 'Amsterdam', url: 'Europe/Amsterdam');
    await data.getTime();
    // print(data.time);
    WeatherData weather = WeatherData();
    await weather.weatherData("Amsterdam");

    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "location": data.location,
      "time": data.time,
      "date": data.date,
      "isDay": data.isDay,
      "dayOfWeek": data.dayOfWeek,
      'temp': weather.temp,
      'feels_like': weather.feels_like,
      'humidity': weather.humidity,
      'wind': weather.wind,
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    print("This is init state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: const Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
