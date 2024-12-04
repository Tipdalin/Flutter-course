import 'package:flutter/material.dart';
import 'screen/device_converter.dart';
 
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 164, 56, 207),
                Color.fromARGB(255, 181, 42, 236),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const DeviceConverter(),
        ),
      ),
    ));
}
