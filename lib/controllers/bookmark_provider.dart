import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/models/request/bookmark/bookmark_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/response/bookmark/all_bookmark.dart';
import '../services/helpers/book_helper.dart';

class BookMarkNotifier extends ChangeNotifier {
  Future<List<AllBookMarkRes>>? bookmarks;
  List<String> _jobs = [];

  List<String> get jobs => _jobs;
  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _jobs.insert(0, jobId);
    prefs.setStringList("jobId", _jobs);
    notifyListeners();
  }

  Future<void> removeJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _jobs.remove(jobId);
    prefs.setStringList("jobId", _jobs);
    notifyListeners();
  }

  Future<void> loadJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final jobs = prefs.getStringList("jobId");
    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookMark(BookmarkRequest bookMark, String jobId) {
    BookMarkHelper.addBookMarks(bookMark).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
          "Bookmark Successfully added",
          "Please check your bookmarks",
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.add_alert),
        );
      } else if (!response[0]) {
        Get.snackbar(
          "Failed to add bookmark",
          "Please try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookMarks(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
          "Bookmark Successfully deleted",
          "Please check your bookmarks",
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.add_alert),
        );
      } else if (!response) {
        Get.snackbar(
          "Failed to delete bookmarks",
          "Please try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  
  fetchAllBookMarks() {
    bookmarks = BookMarkHelper.getAllBookMarks();
  }
}
