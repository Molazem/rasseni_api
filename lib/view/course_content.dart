import 'package:flutter/material.dart';
import 'package:rasseni_api/model/course_item_model.dart';

class CourseContent extends StatelessWidget {
  final List<CourseItem> theCourseItems;
  const CourseContent({super.key, required this.theCourseItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: theCourseItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  theCourseItems[index].title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                tileColor: const Color(0xff3C62DD),
              ),
            );
          }),
    );
  }
}
