import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
    final String id;
    final String username;
    final String email;
    final bool isAdmin;
    final bool isAgent;
    final List<String> skills;
    final String profile;
    final String location;

    ProfileResponse({
        required this.id,
        required this.username,
        required this.email,
        required this.isAdmin,
        required this.isAgent,
        required this.skills,
        required this.profile,
        required this.location,
    });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        profile: json["profile"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "profile": profile,
        "location": location,
    };
}
