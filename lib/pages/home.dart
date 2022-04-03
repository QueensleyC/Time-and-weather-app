import 'package:flutter/material.dart';
import 'package:world_time_app/services/time_zones.dart';
import 'package:world_time_app/services/weather.dart';
import 'package:world_time_app/widget/flexible.dart';
import 'package:world_time_app/widget/weather_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  WeatherData weatherData = WeatherData();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    print("data : $data");
    String backGroundIsDay = data['isDay'] ? 'day.jpeg' : 'night.jpeg';

    weatherData.weatherData(data["location"]);

    TimeZones timeZone = TimeZones();
    timeZone.availableTimeZones();

    Color textColor = data['isDay'] ? Colors.black : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$backGroundIsDay'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/location');
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                        "Edit Location",
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data["location"]}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    sizedBox(10),
                    Text(
                      "${data["dayOfWeek"]}, ${data["date"]} ",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizedBox(20),
                    Text(
                      "${data["time"]}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 66,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sizedBox(20),
                    Text(
                      "- - - - - - - - - - -",
                      style: TextStyle(color: textColor, fontSize: 60),
                    ),
                    sizedBox(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Time Zone",
                          style: TextStyle(
                              color: textColor,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " : ",
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          "${data["timeZone"]}",
                          style: TextStyle(
                              color: textColor,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    sizedBox(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Day light saving",
                          style: TextStyle(
                              color: textColor,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " : ",
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          data["isDst"] == true ? "Active" : "INACTIVE",
                          style: TextStyle(
                              color: textColor,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    sizedBox(100),
                    Text(
                      "Weather information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    additionalInformation(
                      isDay: data["isDay"],
                      temperature: data["temp"],
                      feelsLike: data["feels_like"],
                      wind: data["wind"],
                      humidity: data["humidity"],
                    ),
                    sizedBox(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
