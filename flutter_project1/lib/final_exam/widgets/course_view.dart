import 'package:flutter/material.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key, required String courseName});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SCORE APP",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
