import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerExample extends StatefulWidget {
  @override
  _AccelerometerExampleState createState() => _AccelerometerExampleState();
}

class _AccelerometerExampleState extends State<AccelerometerExample> {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();
    _initAccelerometer();
  }

  void _initAccelerometer() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
      });

      // Check for specific movements based on the accelerometer values
      _checkForMove();
    });
  }

  void _checkForMove() {
    if (_x > 1.5) {
      print("Move to Right");
      Get.rawSnackbar(
        messageText: const Text(
          'Move to the Right',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red[400]!,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else if (_x < -1.5) {
      Get.rawSnackbar(
        messageText: const Text(
          'Move to Left',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red[400]!,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    }

    if (_y > 2.0) {
      print("Move Upwards");
      Get.rawSnackbar(
        messageText: const Text(
          'Move Upwards',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red[400]!,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else if (_y < -1.0) {
      Get.rawSnackbar(
        messageText: const Text(
          'Move Downwards',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red[400]!,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('X: ${_x.toStringAsFixed(2)}'),
          Text('Y: ${_y.toStringAsFixed(2)}'),
          Text('Z: ${_z.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
