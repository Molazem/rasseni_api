import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasseni_api/controller/app_user.dart';
import 'package:rasseni_api/view/course_content.dart';
import 'package:rasseni_api/view/courses_screen.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppUser>(
        builder: (context, user, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CoursesList())),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(480, 100),
                      backgroundColor: const Color(0xff00B232)),
                  child: const Text(
                    'Add Course',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: user.myCoursesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ListTile(
                              title: Text(
                                user.myCoursesList[index].name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              subtitle: LinearProgressIndicator(
                                value: user
                                    .getProgress(user.myCoursesList[index].id),
                                backgroundColor: Colors.grey,
                                color: Colors.green,
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseContent(
                                            theCourseItems: user
                                                .myCoursesList[index].content,
                                          ))),
                              tileColor: const Color(0xffFF7427),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove,
                                    size: 22, color: Colors.white),
                                onPressed: () => user
                                    .removeCourse(user.myCoursesList[index]),
                              ),
                            ),
                          );
                        }))
              ],
            ),
          );
        },
      ),
    );
  }
}
