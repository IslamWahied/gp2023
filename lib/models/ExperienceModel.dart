// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class ExperienceModel {
  String companyName;
  String position;
  String startDate;
  String endDate;
  String uId;

  ExperienceModel({
    this.companyName,
    this.position,
    this.startDate,
    this.endDate,
    this.uId,
  });

  ExperienceModel.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    position = json['position'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'uId': uId
    };
  }
}
