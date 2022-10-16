import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:weather_project/utils/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 5, 39, 67)));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF343258),
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(MyImages.homeBackground,
                  width: width, height: height, fit: BoxFit.cover),
              SizedBox(
                height: height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      child: Text(
                        "Montreal",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      child: Text(
                        "19°",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      child: Text(
                        "Mostly Clear",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      child: Text(
                        "H:24°   L:18°",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        MyImages.house,
                        height: height * 0.4,
                        width: width * 0.9,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
