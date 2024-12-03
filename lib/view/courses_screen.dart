import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasseni_api/controller/app_user.dart';
import 'package:rasseni_api/controller/online_data.dart';
import 'package:rasseni_api/model/courses_model.dart';
import 'package:rasseni_api/view/course_content.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AppUser>(builder: (context, appUser, child) {
      if (appUser.theCoursesList.isEmpty) {
        return const Center(
            child: CircularProgressIndicator()); // Loading state
      }
      return ListView.builder(
          itemCount: appUser.theCoursesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  appUser.theCoursesList[index].name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                trailing: IconButton(
                    onPressed: () =>
                        appUser.addCourse(appUser.theCoursesList[index]),
                    icon: const Icon(
                      Icons.add,
                      size: 22,
                      color: Colors.white,
                    )),
                tileColor: const Color(0xffFF017E),
              ),
            );
          });
    }));
  }
}
