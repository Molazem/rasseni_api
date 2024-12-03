import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider for state management
import 'package:rasseni_api/model/course_item_model.dart';
import 'package:rasseni_api/controller/app_user.dart';
import 'package:rasseni_api/view/actual_course.dart';

class CourseContent extends StatelessWidget {
  final List<CourseItem> theCourseItems;
  final String courseId;

  const CourseContent(
      {super.key, required this.theCourseItems, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppUser>(
        builder: (context, appUser, child) {
          // Get the list of completed item IDs for the course
          final completedItems = appUser.courseProgress[courseId] ?? {};

          return ListView.builder(
            itemCount: theCourseItems.length,
            itemBuilder: (context, index) {
              final item = theCourseItems[index];
              final isCompleted = completedItems.contains(item.id);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: isCompleted ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: isCompleted
                          ? TextDecoration
                              .lineThrough // Strike-through for completed items
                          : TextDecoration.none,
                    ),
                  ),
                  tileColor: isCompleted
                      ? Colors.grey
                          .shade700 // Dim the background for completed items
                      : const Color(0xff3C62DD),
                  onTap: isCompleted
                      ? null // Disable tapping for completed items
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseItemWidget(
                                courseItem: item,
                                courseId: courseId,
                              ),
                            ),
                          ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
