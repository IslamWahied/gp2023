// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class job_model {
  String jobTitle;
  String description;
  String type;
  int salary;
  String role;
  DateTime startDate;
  String uId;

  job_model({
    this.jobTitle,
    this.description,
    this.type,
    this.salary,
    this.role,
    this.startDate,
    this.uId,
  });

  job_model.fromJson(Map<String, dynamic> json) {
    jobTitle = json['jobTitle'];
    description = json['description'];
    type = json['type'];
    salary = json['salary'];
    role = json['role'];
    startDate = json['startDate'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'description': description,
      'type': type,
      'salary': salary,
      'role': role,
      'startDate': startDate,
      'uId': CacheHelper.getData(key: 'uId')
    };
  }
}
