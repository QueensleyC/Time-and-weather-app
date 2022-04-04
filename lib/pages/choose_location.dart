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
  List tz = [];
  List filteredTz = [];

  getData() async {
    TimeZones timeZone = TimeZones();
    tz = await timeZone.availableTimeZones();

    return tz;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> updateTime(int index) async {

      String timeZone = filteredTz.isEmpty? tz[index].toString() : filteredTz[index].toString();

      String location = timeZone;

      if (timeZone.toString().contains("/")) {
        location = timeZone.toString().split("/")[
            1]; //removes "/" that separated continent from city and picks only city
      }
      if (location.contains("_")) {
        location =
            location.replaceAll("_", " "); //removes underscore if there's any
      }

      WorldTime instance =
          WorldTime(url: timeZone.trim(), location: location);
      await instance.getTime();

      WeatherData weather = WeatherData();
      await weather
          .weatherData(location); //gets weather data based on the location

      //Navigate to home screen and pass data to home screen
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'time': instance.time,
        'timeZone': instance.timeZone,
        'isDay': instance.isDay,
        'dayOfWeek': instance.dayOfWeek,
        'date': instance.date,
        'isDst': instance.isDst,
        'temp': weather.temp,
        'feels_like': weather.feelsLike,
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
            _searchBar(),
            Expanded(
              child: Card(
                child: FutureBuilder(
                  //Use future builder because the data takes a few seconds to be retrieved
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount:
                            filteredTz.isEmpty ? tz.length : filteredTz.length,
                        //the item count depends on whether the user is using the search field
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => updateTime(index),
                            child: ListTile(
                              title: Text(
                                //text depends on what is in the searchbar
                                filteredTz.isEmpty
                                    ? tz[index]
                                    : filteredTz[index],
                              ),
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

  _searchBar() {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Search City",
        border: OutlineInputBorder(),
      ),
      onChanged: (query) {
        setState(() {
          query = query
              .toUpperCase(); //changes text written in search bar to upper case
          filteredTz = tz;
          filteredTz = tz
              .where((city) => city.toString().toUpperCase().contains(
                  query)) //changes text in list to upper case so that our search is case insensitive and checks if query is in the list item
              .toList(); //converts the iterable to a list
          // print("filtered list is $filteredTz");
        });
      },
    );
  }
}
