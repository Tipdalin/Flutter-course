import 'package:flutter/material.dart';
import 'package:w3_s2_practice/1-START%20CODE/widgets/course_view.dart';

class CoursesView extends StatelessWidget {
  CoursesView({super.key});

  final List<String> courses = ['HTML', 'CSS', 'JavaScript'];

  void _navigateToCourseView(BuildContext context, String courseName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CourseView(courseName: courseName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "SCORE APP",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(courses[0]),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('3 score'),
                          Text('Average: 67.7'),
                        ],
                      ),
                      onTap: () {
                        _navigateToCourseView(context, 'HTML');
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
