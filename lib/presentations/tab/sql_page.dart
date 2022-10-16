import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/local/local_db.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/presentations/widgets/custom_container.dart';
import 'package:weather_project/utils/colors.dart';


class SqlPage extends StatefulWidget {
  const SqlPage({Key? key}) : super(key: key);

  @override
  State<SqlPage> createState() => _SqlPageState();
}

class _SqlPageState extends State<SqlPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Sql page"),
        backgroundColor: MyColors.backGroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<List<CachedWeatherItem>>(
        future: LocalDatabase.getAllWeathers(),
        builder: (context, AsyncSnapshot<List<CachedWeatherItem>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return FadeInLeftBig(
                  child: CustomContainer(
                    height: height,
                    width: width,
                    temp: snapshot.data![index].temperature,
                    country: snapshot.data![index].addressName,
                    statusWeather: snapshot.data![index].weatherType,
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.backGroundColor,
            ),
          );
        },
      ),
    );
  }
}
