import 'package:flutter/material.dart';
import 'package:weather_project/presentations/widgets/custom_paint.dart';
import 'package:weather_project/utils/icons.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.temp,
    required this.country,
    required this.statusWeather,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  final double height;
  final double width;
  final String temp;
  final String country;
  final String statusWeather;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height * 0.2,
      width: width * 0.97,
      child: Stack(
        children: [
          CustomPaint(
            painter: WeatherCustomPainter(
                color1: color1, color2: color2),
            size: Size(width * 0.97, height * 0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      "$temp°",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    child: Text(
                      "H:24°  L:18° ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      country,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      (statusWeather == "tornado")
                          ? MyIcons.tornado
                          : (statusWeather == "sunny")
                              ? MyIcons.sunWithRain
                              : (statusWeather == "rainy")
                                  ? MyIcons.moonWithCloud
                                  : (statusWeather == "cloudly")
                                      ? MyIcons.bigMoon
                                      : MyIcons.sunWithCloud,
                      height: height * 0.13,
                      width: width * 0.25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      statusWeather,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
