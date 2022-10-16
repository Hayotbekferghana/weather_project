import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/presentations/widgets/custom_container.dart';
import 'package:weather_project/utils/colors.dart';


class SqlPage extends StatelessWidget {
  const SqlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.backGroundColor,
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: 13,
          itemBuilder: (_, index){
            return FadeInLeftBig(
              child: CustomContainer(
                height: height,
                width: width,
                temp: '19',
                country: 'Tashkent, Uzbekistan',
                statusWeather: 'sunny',
              ),
            );
          },
        ),
      )
    );
  }
}

/*
 */
