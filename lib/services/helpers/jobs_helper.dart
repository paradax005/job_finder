import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/response/jobs/job_response.dart';

import '../config.dart';

class JobsHelper {
  static var client = https.Client();

  /// GET JOBS
  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      List<JobsResponse> jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception('Failed to fetch available jobs');
    }
  }

  /// GET RECENTLY POSTED JOBS
  static Future<JobsResponse> getRecentlyJobs() async {
    print(
        "<<<<<<<<<<<<<<< GET RECENTLY POSTED JOBS Methods was called >>>>>>>>>>>>>>>>>");
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      List<JobsResponse> jobsList = jobsResponseFromJson(response.body);
      return jobsList.first;
    } else {
      throw Exception('Failed to fetch available jobs');
    }
  }

  /// GET Job By Id
  static Future<JobsResponse> getSpecificJob(String jobId) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return JobsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch available job');
    }
  }

  /// Search For a Job
  static Future<List<JobsResponse>> searchJob(String searchQuery) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$searchQuery");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return jobsResponseFromJson(response.body);
    } else {
      throw Exception('Failed to fetch available job');
    }
  }
}
