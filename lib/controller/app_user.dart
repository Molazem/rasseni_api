import 'package:flutter/material.dart';
import 'package:rasseni_api/controller/online_data.dart';
import 'package:rasseni_api/model/courses_model.dart';

class AppUser extends ChangeNotifier {
  List<CoursesModel> theCoursesList = [];
  List<CoursesModel> myCoursesList = [];
  bool _isLoading = false;
  Map<String, double> courseProgress = {}; // Track progress for each course

  AppUser() {
    _loadData();
  }
  void _filterLoadedCourses() {
    theCoursesList.removeWhere(
        (item) => myCoursesList.any((myItem) => myItem.name == item.name));
  }

  void addCourse(CoursesModel theCourse) {
    myCoursesList.add(theCourse);
    theCoursesList.removeWhere((item) => item.name == theCourse.name);
    notifyListeners();
  }

  void removeCourse(CoursesModel theCourse) {
    theCoursesList.add(theCourse);
    myCoursesList.removeWhere((item) => item.name == theCourse.name);
    notifyListeners();
  }

  // Asynchronous loading of data
  Future<void> _loadData() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final courses = await OnlineData().theCoursesList();
      if (courses != null) {
        theCoursesList = courses;
        _filterLoadedCourses();
        notifyListeners();
      }
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      _isLoading = false;
    }
  }

  void updateProgress(String courseId, double progress) {
    if (courseProgress.containsKey(courseId)) {
      courseProgress[courseId] = progress;
      notifyListeners();
    }
  }

  double getProgress(String courseId) {
    return courseProgress[courseId] ?? 0.0;
  }

  Map<String, List<CoursesModel>> getCoursesByLabel() {
    Map<String, List<CoursesModel>> coursesByLabel = {};
    for (var course in theCoursesList) {
      if (!coursesByLabel.containsKey(course.label)) {
        coursesByLabel[course.label] = [];
      }
      coursesByLabel[course.label]!.add(course);
    }
    return coursesByLabel;
  }

  void completeCourseItem(String courseId, String itemId) {
    final course =
        myCoursesList.firstWhere((c) => c.id == courseId, orElse: () => null);
    if (course != null) {
      final completedItems =
          course.content.where((item) => item.id == itemId).length;
      final totalItems = course.content.length;

      if (totalItems > 0) {
        final progress = completedItems / totalItems;
        updateProgress(courseId, progress);
      }
    }
  }
}
