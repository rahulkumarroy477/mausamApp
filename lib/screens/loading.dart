import 'package:flutter/material.dart';
import 'package:mausam_app/screens/home.dart';
import 'package:mausam_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "";
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, show an error message or prompt the user to enable them.
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied location permission permanently.
      // Show an error message or redirect them to the app settings.
      return;
    }

    if (permission == LocationPermission.denied) {
      // The user has denied location permission for the app. Request permission.
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permissions are denied. Show an error message or redirect them to the app settings.
        return;
      }
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Access the latitude and longitude
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Do something with the location coordinates
    print('Latitude: $latitude, Longitude: $longitude');

    // Perform reverse geocoding to get the city name
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      var cityName = placemarks[0].locality;
      city = cityName!;
      print('City: $cityName');
    }
  }

  Future<void> startApp() async {
    // location agar galat hai
    // List<String> indianCities = [
    //   'Patna',
    //   'Mumbai',
    //   'Delhi',
    //   'Bangalore',
    //   'Chennai',
    //   'Kolkata',
    //   'Hyderabad',
    //   'Ahmedabad',
    //   'Pune',
    //   'Jaipur',
    //   'Lucknow'
    // ];

    // int randomIndex = Random().nextInt(indianCities.length);

    // Retrieve the random city
    // String city = indianCities[randomIndex];
    Worker w = Worker(city);
    await w.getData();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(data: w.data),
        ),
      );
    });
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/weather-icon-14.jpg',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 70,
                ),
                const SpinKitWave(
                  color: Colors.purple,
                  size: 50.0,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Mausam App',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Created by Rahul',
                  style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                ),
              ],
            ),
          ),
        ));
  }
}
