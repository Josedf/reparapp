import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reparapp/domain/controller/location_controller.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class FixerMap extends StatefulWidget {
  const FixerMap({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FixerMap> {
  final FirestoreService _firestoreService = Get.find();
  LocationController locationController = Get.find();
  void initState() {
    super.initState();
    // User? user = FirebaseAuth.instance.currentUser;
    // String? em = user!.email;
    getRequestInfo();
  }

  void getRequestInfo() async {}

  int clientLat = 0;
  int clientLon = 0;

  late GoogleMapController googleMapController;

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    printInfo(info: 'Creating new bounds');
    return _createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ElevatedButton(
                  //     key: const Key("clear"),
                  //     onPressed: () async {
                  //       locationController.clearLocation();
                  //     },
                  //     child: const Text("Clear")),
                  ElevatedButton(
                      key: const Key("client loc"),
                      onPressed: () async {
                        locationController.updatedMarker();
                      },
                      child: const Text("client loc")),
                  ElevatedButton(
                      key: const Key("currentLocation"),
                      onPressed: () async {
                        locationController.getLocation();
                      },
                      child: const Text("Current")),

                  // ElevatedButton(
                  //     key: const Key("cancel"),
                  //     onPressed: () async {
                  //       locationController.clearLocation();
                  //       Get.back();
                  //     },
                  //     child: const Text("Cancel")),
                  // ElevatedButton(
                  //     key: const Key("accept"),
                  //     onPressed: () async {
                  //       if (locationController.userLocation.value.latitude ==
                  //               0 &&
                  //           locationController.userLocation.value.longitude ==
                  //               0) {
                  //         Get.snackbar('Error', 'Please select your location',
                  //             snackPosition: SnackPosition.BOTTOM,
                  //             backgroundColor: Color(0xFF808080),
                  //             colorText: Colors.white,
                  //             borderRadius: 10,
                  //             margin: EdgeInsets.all(10),
                  //             snackStyle: SnackStyle.FLOATING,
                  //             duration: Duration(seconds: 3));
                  //       } else {
                  //         Get.back();
                  //       }
                  //     },
                  //     child: const Text("Accept")),
                  Obx(() => ElevatedButton(
                      key: const Key("changeLiveUpdate"),
                      onPressed: () {
                        if (!locationController.liveUpdate) {
                          locationController.suscribeLocationUpdates();
                        } else {
                          locationController.unSuscribeLocationUpdates();
                        }
                      },
                      child: Text(locationController.liveUpdate
                          ? "Set live updates off"
                          : "Set live updates on"))),
                  ElevatedButton(
                      key: const Key("back"),
                      onPressed: () async {
                        locationController.clearLocation();
                        Get.back();
                      },
                      child: const Text("back")),
                ],
              ),
              GetX<LocationController>(builder: (controller) {
                printInfo(info: 'Recreating map');
                return Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(controller.markers.values),
                    myLocationEnabled: true,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(11.0227767, -74.81611),
                      zoom: 17.0,
                    ),
                  ),
                );
              }),
              GetX<LocationController>(
                builder: (controller) {
                  if (locationController.markers.values.isNotEmpty) {
                    googleMapController.animateCamera(
                        CameraUpdate.newLatLngBounds(
                            _bounds(Set<Marker>.of(
                                locationController.markers.values)),
                            50));
                  } else {
                    if (controller.userLocation.value.latitude != 0) {
                      googleMapController.moveCamera(CameraUpdate.newLatLng(
                          LatLng(controller.userLocation.value.latitude,
                              controller.userLocation.value.longitude)));
                    }
                  }
                  printInfo(
                      info: "UI <" +
                          controller.userLocation.value.latitude.toString() +
                          " " +
                          controller.userLocation.value.longitude.toString() +
                          ">");

                  return Text(
                    controller.userLocation.value.latitude.toString() +
                        " " +
                        controller.userLocation.value.longitude.toString(),
                    key: const Key("position"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
