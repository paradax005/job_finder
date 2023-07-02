import 'dart:convert';

List<JobsResponse> jobsResponseFromJson(String str) => List<JobsResponse>.from(json.decode(str).map((x) => JobsResponse.fromJson(x)));

class JobsResponse {
    final String id;
    final String title;
    final String location;
    final String company;
    final String description;
    final String salary;
    final String period;
    final String contract;
    final List<String> requirements;
    final String imageUrl;
    final String agentId;

    JobsResponse({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        required this.description,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirements,
        required this.imageUrl,
        required this.agentId,
    });

    factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        description: json["description"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "description": description,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
    };
}
