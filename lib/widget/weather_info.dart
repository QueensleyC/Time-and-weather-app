import 'package:flutter/material.dart';

Widget additionalInformation(
    {required bool isDay,
    required double temperature,
    required double feelsLike,
    required double wind,
    required int humidity}) {

  Color textColor = isDay ? Colors.black : Colors.white;

  TextStyle titleFont =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: textColor);
  TextStyle infoFont =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: textColor);

  return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Temperature", style: titleFont),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Feels like", style: titleFont),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$temperature", style: infoFont),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("$feelsLike", style: infoFont),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Humidity", style: titleFont),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Wind", style: titleFont),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$humidity %", style: infoFont),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("$wind m/s", style: infoFont),
                ],
              ),
            ],
          )
        ],
      ));
}
