import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GetLocationController {
  static GetLocationController instance = Get.find();

  String coordinates = "No Location found";
  String address = 'No Address found';
  bool scanning = false;

  checkPermission() async {
    print("Called checkPermission................................");

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print(serviceEnabled);

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Request Denied !');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Denied Forever !');
      return;
    }

    getLocation();
  }

  getLocation() async {
    // setState(() {scanning=true;});

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      coordinates =
          'Latitude : ${position.latitude} \nLongitude : ${position.longitude}';

      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (result.isNotEmpty) {
        // address =
        //     '${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';
        
        address = '${result[0].locality}, ${result[0].administrativeArea}, ${result[0].subAdministrativeArea}';

        print(
            "Address found is: $address ..............................................");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }

    // setState(() {scanning=false;});
  }
}
