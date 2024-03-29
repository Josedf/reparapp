import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:reparapp/Models/user_location.dart';

class LocatorService {
  StreamSubscription<Position>? _positionStreamSubscription;

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Geolocator geolocator = Geolocator();
  Stream<UserLocation> get stream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    UserLocation userLocation;
    try {
      Position l = await Geolocator.getCurrentPosition();
      userLocation = UserLocation(latitude: l.latitude, longitude: l.longitude);
      return Future.value(userLocation);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> startStream() async {
    printInfo(info: "startStream with Locator library");
    _positionStreamSubscription =
        Geolocator.getPositionStream().handleError((onError) {
      printError(info: "Got error from Geolocator stream");
      return Future.error(onError.toString());
    }).listen((event) {
      //_controller.sink.add(UserLocation.fromPosition(event));
      _locationController.add(UserLocation.fromPosition(event));
    });
  }

  stopStream() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
    } else {
      printError(info: "stopStream _positionStreamSubscription is null");
    }
  }
}
