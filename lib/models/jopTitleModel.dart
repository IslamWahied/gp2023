// @dart=2.9
// ignore_for_file: non_constant_identifier_names, missing_return

class SkillsModel {

  List<SkillsDataModel> data;


  SkillsModel(
      {
        this.data,
    });

  SkillsModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <SkillsDataModel>[];
      json['data'].forEach((v) {
        data.add(SkillsDataModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class SkillsDataModel {
  int id;
  String name;

  SkillsDataModel({this.id, this.name});

  SkillsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
