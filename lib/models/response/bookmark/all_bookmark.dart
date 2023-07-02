import 'dart:convert';

import '../jobs/job_response.dart';

List<AllBookMarkRes> allBookMarkResFromJson(String str) => List<AllBookMarkRes>.from(json.decode(str).map((x) => AllBookMarkRes.fromJson(x)));

String allBookMarkResToJson(List<AllBookMarkRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookMarkRes {
    final String id;
    final JobsResponse job;
    final String userId;

    AllBookMarkRes({
        required this.id,
        required this.job,
        required this.userId,
    });

    factory AllBookMarkRes.fromJson(Map<String, dynamic> json) => AllBookMarkRes(
        id: json["_id"],
        job: JobsResponse.fromJson(json["job"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job.toJson(),
        "userId": userId,
    };
}

