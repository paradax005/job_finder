import 'package:flutter/material.dart';
import 'package:job_finder/models/response/jobs/job_response.dart';
import 'package:job_finder/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobsList;
  late Future<JobsResponse> recentJob;
  late Future<JobsResponse> jobDetail;

  getJobs() {
    jobsList = JobsHelper.getJobs();
  }

  getRecentJob() {
    recentJob = JobsHelper.getRecentlyJobs();
  }

  getJob(String id) {
    jobDetail = JobsHelper.getSpecificJob(id);
  }
}
