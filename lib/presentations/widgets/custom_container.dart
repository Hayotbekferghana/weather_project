import 'package:flutter/material.dart';
import 'package:weather_project/presentations/widgets/custom_paint.dart';
import 'package:weather_project/utils/icons.dart';

class CustomContainer extends StatefulWidget {
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
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation colorAnimation;
  late final Animation colorAnimation1;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          });
    colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 122, 69, 255).withOpacity(1),
      end: const Color.fromARGB(255, 22, 7, 119).withOpacity(1),
    ).animate(controller);
    colorAnimation1 = ColorTween(
      begin: const Color(0xff392C88).withOpacity(1),
      end: const Color(0xff5835B2).withOpacity(1),
    ).animate(controller);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: widget.height * 0.2,
      width: widget.width * 0.97,
      child: Stack(
        children: [
          CustomPaint(
            painter: WeatherCustomPainter(
                color1: colorAnimation.value, color2: colorAnimation1.value),
            size: Size(widget.width * 0.97, widget.height * 0.3),
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
                      "${widget.temp}°",
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
                      widget.country,
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
                      (widget.statusWeather == "tornado")
                          ? MyIcons.tornado
                          : (widget.statusWeather == "sunny")
                              ? MyIcons.sunWithRain
                              : (widget.statusWeather == "rainy")
                                  ? MyIcons.moonWithCloud
                                  : (widget.statusWeather == "cloudly")
                                      ? MyIcons.bigMoon
                                      : MyIcons.sunWithCloud,
                      height: widget.height * 0.13,
                      width: widget.width * 0.25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      widget.statusWeather,
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
