import 'package:flutter/material.dart';
import 'package:world_time_app/services/time_zones.dart';
import 'package:world_time_app/services/weather.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final TextEditingController _cityController = TextEditingController();

  List tz = [];

  getData() async {
    TimeZones timeZone = TimeZones();
    tz = await timeZone.availableTimeZones();
    return tz;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> updateTime(int index) async {
      String location = tz[index].toString().split("/")[1];
      if (location.contains("_")) {
        location = location.replaceAll("_", " ");
      }

      WorldTime instance =
          WorldTime(url: tz[index].toString().trim(), location: location);
      await instance.getTime();

      WeatherData weather = WeatherData();
      await weather.weatherData(location);

      //Navigate to home screen and pass data to home page
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'time': instance.time,
        'timeZone': instance.timeZone,
        'isDay': instance.isDay,
        'dayOfWeek': instance.dayOfWeek,
        'date': instance.date,
        'isDst': instance.isDst,
        'temp': weather.temp,
        'feels_like': weather.feels_like,
        'humidity': weather.humidity,
        'wind': weather.wind,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                  hintText: "Search City", border: OutlineInputBorder()),
            ),
            Expanded(
              child: Card(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: tz.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => updateTime(index),
                            child: ListTile(
                              title: Text(tz[index]),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
