import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/presentation/home_screen/home_screen_cubit/home_screen_states.dart';
import 'package:weather/services/location_api.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  Position? positionOfUser;

  initLocationService() async {
    int locationCheckingResult = await LocationApi.getLocation();
    if (locationCheckingResult == LocationApi.locationServiceIsDisabled) {
      emit(LocationServicesDisabledState());
      debugPrint('Dis');
    } else if (locationCheckingResult == LocationApi.deniedPermission) {
      emit(DeniedPermissionState());
      debugPrint('Den');
    } else {
      emit(LoadingGettingPositionState());
      positionOfUser = await LocationApi.getPosition();
      emit(LocationSuccessfullySetState());
      debugPrint('Done');
    }
  }

  void locationListener() {
    late StreamSubscription streamSubscription;
    Stream stream = Geolocator.getServiceStatusStream();
    streamSubscription = stream.listen((event) async {
      if (event == ServiceStatus.enabled) {
        //emit loading state while getting the permission or the position
        emit(LoadingSettingLocationState());
        await initLocationService();
      } else {
        //To recheck and emit the suitable state
        await initLocationService();
      }
      streamSubscription.cancel(); //To close the stream
    });
  }

  openLocationSettingsAndRetry() async {
    await LocationApi.openLocationSettings();
    locationListener();
  }
}
