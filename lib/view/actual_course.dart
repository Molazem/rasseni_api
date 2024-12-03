import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasseni_api/controller/app_user.dart';
import 'package:rasseni_api/model/course_item_model.dart';

class CourseItemWidget extends StatelessWidget {
  final CourseItem courseItem;
  final String courseId; // ID of the parent course

  const CourseItemWidget({
    super.key,
    required this.courseItem,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    // Check if this item is marked as completed
    bool isCompleted = appUser.isItemCompleted(courseId, courseItem.id);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 34),
            Text(
              courseItem.title,
              style: TextStyle(
                fontSize: 22,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 80),
            Container(
              height: 200,
              color: Colors.black54,
              child: Center(
                child: Text(
                  courseItem.url,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                appUser.updateProgress(courseId, courseItem.id, !isCompleted);
                Navigator.pop(context); // Return to the previous screen
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(480, 100),
                backgroundColor: const Color(0xff00B232),
              ),
              child: Text(
                isCompleted ? 'Mark as Incomplete' : 'Completed',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
