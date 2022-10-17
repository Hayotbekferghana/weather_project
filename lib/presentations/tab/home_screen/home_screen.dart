import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/cubit/notification_cubit/notification_cubit.dart';
import 'package:weather_project/presentations/tab/home_screen/widgets/custom_text_field.dart';

import 'package:weather_project/utils/icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  List<String> weatherTypes = [
    "sunny",
    "tornado",
    "rainy",
    "cloudly",
  ];
  String weatherType = 'sunny';
  @override
  void dispose() {
    addressController.dispose();
    tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 5, 39, 67)));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF343258),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(MyIcons.homeBackground,
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
                          MyIcons.house,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextField(
                          controller: addressController,
                          hintText: "Address",
                          context: context),
                      CustomTextField(
                        controller: tempController,
                        hintText: "Temperature",
                        context: context,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Weather type"),
                          DropdownButton(
                            value: weatherType,
                            items: weatherTypes.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              weatherType = value!;
                              setState(() {});
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      if (addressController.text.isNotEmpty &&
                          tempController.text.isNotEmpty) {
                        context.read<NotificationCubit>().postNotification(
                              address: addressController.text,
                              weatherType: weatherType,
                              temp: tempController.text,
                            );
                      }
                      addressController.clear();
                      tempController.clear();
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text("Add"),
                    ))
              ],
            ),
          );
        },
        child: const Center(child: Icon(Icons.notification_add)),
      ),
    );
  }
}
