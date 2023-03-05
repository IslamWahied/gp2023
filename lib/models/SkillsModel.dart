// @dart=2.9
import 'package:gp2023/shared/network/local/cache_helper.dart';

class SkillModel {
  String skillName;
  String uId;

  SkillModel({
    this.skillName,
    this.uId,
  });

  SkillModel.fromJson(Map<String, dynamic> json) {
    skillName = json['skillName'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {'skillName': skillName, 'uId': uId};
  }
}
