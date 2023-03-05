// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class WorkableUserModel {
  String name;
  String email;
  String phone;
  String uId;
  bool isMale;
  bool isEmailVerified;
  String password;
  bool isApplicant;

  WorkableUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isMale,
    this.isEmailVerified,
    this.isApplicant,
    this.password,
  });

  WorkableUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = CacheHelper.getData(key: 'uId');
    isMale = json['isMale'];
    isEmailVerified = json['isEmailVerified'];
    password = json['password'];
    isApplicant = json['isApplicant'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isMale': isMale,
      'isEmailVerified': isEmailVerified,
      'uId': uId,
      'password': password,
      'isApplicant': isApplicant
    };
  }
}
