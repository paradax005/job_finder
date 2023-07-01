import 'dart:convert';


String profileUpdateRequestToJson(ProfileUpdateRequest data) => json.encode(data.toJson());

class ProfileUpdateRequest {
    final String location;
    final String phone;
    final String profileImg;
    final List<String> skills;

    ProfileUpdateRequest({
        required this.location,
        required this.phone,
        required this.profileImg,
        required this.skills,
    });


    Map<String, dynamic> toJson() => {
        "location": location,
        "phone": phone,
        "profile": profileImg,
        "skills": List<dynamic>.from(skills.map((x) => x)),
    };
}
