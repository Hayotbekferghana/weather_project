import 'package:flutter/material.dart';
import 'package:weather_project/utils/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(MyImages.homeBackground, width: width, height: height, fit: BoxFit.cover),
            const Positioned(
                top: 100,
              left: 140,
              child: Text("Montreal", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400, color: Colors.white),),
            ),
            const Positioned(
              top: 150,
              left: 170,
              child: Text("19°", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: Colors.white),),
            ),
            const Positioned(
              top: 200,
              left: 140,
              child: Text("Mostly Clear", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white),),
            ),
            const Positioned(
              top: 250,
              left: 140,
              child: Text("H:24°   L:18°", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200, color: Colors.white),),
            ),
             Positioned(
              top: 360,
              left: 10,
              child: Image.asset(MyImages.house, height: height * 0.4, width: width * 0.9, fit: BoxFit.fill,)
            )
          ],
        ),
      ),
    );
  }
}