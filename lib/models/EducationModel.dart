// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class EducationModel {
  String educationLevel;
  String university;
  String faculty;
  String startDate;
  String endDate;
  String uId;

  EducationModel({
    this.educationLevel,
    this.university,
    this.faculty,
    this.startDate,
    this.endDate,
    this.uId,
  });

  EducationModel.fromJson(Map<String, dynamic> json) {
    educationLevel = json['educationLevel'];
    university = json['university'];
    faculty = json['faculty'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'educationLevel': educationLevel,
      'university': university,
      'faculty': faculty,
      'startDate': startDate,
      'endDate': endDate,
      'uId': uId
    };
  }
}
