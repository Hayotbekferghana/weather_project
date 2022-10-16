import 'package:flutter/material.dart';
import 'package:weather_project/presentations/widgets/custom_paint.dart';
import 'package:weather_project/utils/images.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.temp,
    required this.country,
    required this.statusWeather,
  }) : super(key: key);

  final double height;
  final double width;
  final String temp;
  final String country;
  final String statusWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height * 0.2,
      width: width * 0.97,
      child: Stack(
        children: [
          CustomPaint(
            painter: WeatherCustomPainter(),
            size: Size(width * 0.97, height * 0.2),
          ),
          Positioned(
            right: 10,
            child: Image.asset(
              (statusWeather == "tornado") ? MyImages.tornado :
              (statusWeather == "sunny") ? MyImages.sunWithRain :
              (statusWeather == "rainy") ? MyImages.moonWithCloud :
              (statusWeather == "cloudly") ? MyImages.bigMoon:
              MyImages.sunWithCloud,
              height: height * 0.18,
              width: width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              left: 15,
              top: 30,
              child: Text(
                "$temp°",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 50),
              )),
          const Positioned(
              left: 15,
              top: 120,
              child: Text(
                "H:24°  L:18° ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              )),
          Positioned(
              left: 15,
              top: 140,
              child: Text(
                country,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              )),
          Positioned(
              right: 15,
              top: 140,
              child: Text(
                statusWeather,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ))
        ],
      ),
    );
  }
}