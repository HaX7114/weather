import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_style.dart';
import 'package:weather/presentation/home_screen/home_screen_cubit/home_screen_cubit.dart';
import 'package:weather/presentation/home_screen/home_screen_cubit/home_screen_states.dart';
import 'package:weather/presentation/home_screen/widgets/alert_dialogs/show_location_services_disabled_dialog.dart';
import 'package:weather/presentation/home_screen/widgets/content_container.dart';
import 'package:weather/presentation/home_screen/widgets/flexible_space_bar.dart';
import 'package:weather/presentation/home_screen/widgets/header_container.dart';
import 'package:weather/presentation/home_screen/widgets/sliver_title_widget.dart';
import 'package:weather/presentation/home_screen/widgets/sunrise_sunset.dart';
import 'package:weather/presentation/home_screen/widgets/temp_forcasting_container.dart';
import 'package:weather/presentation/home_screen/widgets/weeklyContainer.dart';
import 'package:weather/presentation/home_screen/widgets/wind_humidity.dart';
import 'package:weather/presentation/shared_widgets/my_text.dart';
import 'package:weather/utils/functions/navigation_functions.dart';
import 'package:weather/utils/styles/colors.dart';
import 'package:weather/utils/styles/spaces.dart';

import '../drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  final WeatherStyle weatherStyle;
  const HomeScreen({Key? key, required this.weatherStyle}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController sc = ScrollController();
  late Color color1; //Animated Color1 Background
  late Color color2; //Animated Color2 Background
  Color sliverAppBarColor = transparentColor;
  Color animatedContainerColor = whiteColor;
  String sliverAppBarTitle = '';
  double scrollOffset = 0.0;
  double headerAnimatedContainerHeight = 0.0;
  double headerAnimatedContainerIconSize = 0.0;
  //This boolean will make us avoid creating the same dialog again as we will use stream to listen on the location service
  bool dialogIsShown = false;
  Widget sliverTitle = MyText(
    text: "",
    size: 1.0,
  );

  //Used in the home screen
  void setAnimatedContentContainerColor() {
    animatedContainerColor = const Color(0XFF646464);
  }

  void resetAnimatedContentContainerColor() {
    animatedContainerColor = whiteColor;
  }

  void setHeightAndIconSize() {
    headerAnimatedContainerHeight = 120.0;
    headerAnimatedContainerIconSize = 70.0;
  }

  void resetHeightAndIconSize() {
    headerAnimatedContainerHeight = 0.0;
    headerAnimatedContainerIconSize = 0.0;
  }

  void handleWhileScrollingDown() {
    color1 = blackColor;
    color2 = blackColor;

    sliverTitle = setSliverTitle();
    sliverAppBarColor = blackColor;
    setAnimatedContentContainerColor();
    setHeightAndIconSize();
  }

  void handleWhileScrollingUp() {
    color1 = widget.weatherStyle.colorOne
        .withOpacity(widget.weatherStyle.colorOpacity);
    color2 = widget.weatherStyle.colorTwo;

    sliverTitle = removeSliverTitle();
    sliverAppBarColor = transparentColor;
    resetAnimatedContentContainerColor();
    resetHeightAndIconSize();
  }

  Widget removeSliverTitle() {
    return MyText(text: "", size: 1.0);
  }

  Widget setSliverTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: SliverTitleWidget(locationName: "El Hay El Asher"),
      ),
    );
  }

  @override
  void initState() {
    color1 = widget.weatherStyle.colorOne
        .withOpacity(widget.weatherStyle.colorOpacity);
    color2 = widget.weatherStyle.colorTwo;

    sc.addListener(() {
      scrollOffset = sc.offset;
      if (scrollOffset > 180) {
        handleWhileScrollingDown();
      } else {
        handleWhileScrollingUp();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..initLocationService(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (listenerContext, state) {
          if (state is LocationServicesDisabledState && !dialogIsShown ||
              state is DeniedPermissionState && !dialogIsShown) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                dialogIsShown = true;
                return WillPopScope(
                  onWillPop: () async => false,
                  child: ShowLocationServicesDisabledDialog(
                    cubit: HomeScreenCubit.get(listenerContext),
                  ),
                );
              },
            );
          }
          //state is LocationSuccessfullySetState && dialogIsShown to avoid popping the the home screen instead of the alert dialog
          if (state is LocationSuccessfullySetState && dialogIsShown) {
            dialogIsShown = false; //reset
            navigateBack(context); //Remove the dialog
          }
        },
        builder: (context, state) {
          return Scaffold(
            drawer: const MyDrawer(),
            body: Stack(
              children: [
                FadeIn(
                  duration: const Duration(seconds: 3),
                  child: LottieBuilder.asset(
                    widget.weatherStyle.weatherLottie,
                    fit: widget.weatherStyle.weatherLottieFitStyle,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                AnimatedContainer(
                  height: double.infinity,
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color1, color2],
                      stops: const [0.25, 0.9],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                NestedScrollView(
                  floatHeaderSlivers: true,
                  controller: sc,
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: transparentColor, // status bar color
                        statusBarIconBrightness: Brightness.light,
                        statusBarBrightness: Brightness.light,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 25.0,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                          sliverTitle,
                        ],
                      ),
                      leadingWidth: 0.0,
                      backgroundColor: sliverAppBarColor,
                      elevation: 0.0,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      expandedHeight: 280.0,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.only(
                          top: 120.0,
                          right: 20.0,
                          left: 20.0,
                        ),
                        child: FlexibleBar(
                          sliverTitle: 'Midan Al Fransawy',
                          maxTemp: 34,
                          currentTemp: 33,
                          minTemp: 24,
                          day: 'Sun',
                          currentTime: '11:50 PM',
                          weatherIcon: widget.weatherStyle.weatherIcon,
                          weatherIconColor:
                              widget.weatherStyle.weatherIconColor,
                        ),
                      ),
                    ),
                  ],
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 50.0,
                      ),
                      child: Column(
                        children: [
                          AnimatedContentContainer(
                            height: 180.0,
                            contentWidget:
                                TemperatureForecastingContainer(temps: d),
                            animatedContainerColor: animatedContainerColor,
                          ),
                          K_vSpace10,
                          //Tomorrow
                          AnimatedContentContainer(
                            height: 220.0,
                            animatedContainerColor: animatedContainerColor,
                            contentWidget: WeeklyContainer(days: days),
                          ),
                          K_vSpace10,
                          //sunrise
                          AnimatedContentContainer(
                            height: 150.0,
                            contentWidget: const SunriseSunsetContainer(
                              sunriseTime: '5:00 AM',
                              sunsetTime: '6:30 PM',
                            ),
                            animatedContainerColor: animatedContainerColor,
                          ),
                          K_vSpace10,
                          AnimatedContentContainer(
                            height: 150.0,
                            contentWidget: const WindHumidityContainer(
                              uvIndex: 'High',
                              wind: '23',
                              humidity: '31',
                            ),
                            animatedContainerColor: animatedContainerColor,
                          ),
                          K_vSpace20,
                        ],
                      ),
                    ),
                  ),
                ),
                //The header container of the temp
                HeaderContainerOfTheTemp(
                  headerAnimatedContainerHeight: headerAnimatedContainerHeight,
                  headerAnimatedContainerIconSize:
                      headerAnimatedContainerIconSize,
                  currentTemp: 33,
                  currentTime: "11:50 PM",
                  day: 'Sun',
                  maxTemp: 34,
                  minTemp: 24,
                  weatherIcon: widget.weatherStyle.weatherIcon,
                  weatherIconColor: widget.weatherStyle.weatherIconColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }
}

List<int> d = [20, 22, 23, 24, 23, 23, 22, 21, 21, 19, 15, 10];
List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
