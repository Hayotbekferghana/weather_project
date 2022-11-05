import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_project/cubit/notification_cubit/notification_cubit.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';
import 'package:weather_project/presentations/widgets/custom_container.dart';
import 'package:weather_project/utils/colors.dart';
import 'package:weather_project/utils/icons.dart';

class WeathersScreen extends StatefulWidget {
  const WeathersScreen({Key? key}) : super(key: key);

  @override
  State<WeathersScreen> createState() => _WeathersScreenState();
}

class _WeathersScreenState extends State<WeathersScreen>
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.backGroundColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Weathers"),
        centerTitle: true,
        backgroundColor: MyColors.backGroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      content: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text("Are you sure delete  all weathers"),
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () async {
                                context
                                    .read<NotificationCubit>()
                                    .deleteAllWeathers();
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: Text("No"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInProgress) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is NotificationInSuccess) {
            List<CachedWeatherItem> weathers = state.weathers;
            if (weathers.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  CachedWeatherItem weatherItem = weathers[index];
                  return BounceInLeft(
                    duration: const Duration(seconds: 2),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        dismissible: DismissiblePane(onDismissed: () async {
                          context
                              .read<NotificationCubit>()
                              .deleteWeatherById(weatherItem.id!);
                          context.read<NotificationCubit>().getAllWeathers();
                        }),
                        motion: const ScrollMotion(),
                        children: const [],
                      ),
                      child: CustomContainer(
                        height: height,
                        width: width,
                        temp: weatherItem.temperature,
                        country: weatherItem.addressName,
                        statusWeather: weatherItem.weatherType,
                        color1: colorAnimation.value,
                        color2: colorAnimation1.value,
                      ),
                    ),
                  );
                },
              );
            } else if (weathers.isEmpty) {
              return Center(
                child: Lottie.asset(MyIcons.emptyLottie),
              );
            }
          } else if (state is NotificationInFailure) {
            return Center(
              child: Text(
                state.errorText,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
