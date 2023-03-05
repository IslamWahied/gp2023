// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class CVModel {
  String jobTitle;
  String degree;
  String city;
  String gender;
  String nationality;
  DateTime dateOfBirth;
  String uId;



  CVModel({
    this.jobTitle,
    this.degree,
    this.city,
    this.gender,
    this.nationality,
    this.dateOfBirth,
    this.uId,

  });

  CVModel.fromJson(Map<String, dynamic> json) {
    jobTitle = json['jobTitle'];
    degree = CacheHelper.getData(key: 'degree');
    city = json['city'];

    gender = json['gender'];
    nationality = json['nationality'];
    dateOfBirth = json['dateOfBirth'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'degree': degree,
      'city': city,
      'gender': gender,
      'nationality': nationality,
      'dateOfBirth': dateOfBirth,
      'uId': uId,

    };
  }
}
