// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/models/SkillsModel.dart';
import 'package:gp2023/models/jopTitleModel.dart';
import 'package:gp2023/modules/applicant_create_Skills/cubit/states.dart';
import 'package:gp2023/shared/components/components.dart';


class ApplicantCreateSkillsCubit extends Cubit<ApplicantCreateSkillsStates> {
  ApplicantCreateSkillsCubit() : super(ApplicantCreateSkillsInitialState());

  static ApplicantCreateSkillsCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  void ExperienceCreate(context,{@required String uId}) {
    if (selectedSkills != []) {
      for (var element in selectedSkills) {
        SkillModel model = SkillModel(skillName: element.name, uId: uId);
        saveSkillData(model,context);
      }
    }
  }

  void saveSkillData(SkillModel M,context) {
    FirebaseFirestore.instance
        .collection('ApplicantSkills')
        .add(M.toMap())
        .then((value) {
      emit(ApplicantCreateSkillsSuccessState(M.uId));
      navigateTo(context, const ApplicantLayout());
      showToast(text: 'Loading...', state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(ApplicantCreateSkillsErrorState(error.toString()));
    });
  }

  List<SkillsDataModel> selectedSkills = [];
  List<SkillsDataModel> SkillsItems = [
    SkillsDataModel(id: 1, name: 'flutter'),
    SkillsDataModel(id: 1, name: 'Java'),
    SkillsDataModel(id: 1, name: 'PHP'),
    SkillsDataModel(id: 1, name: 'Angular'),
    SkillsDataModel(id: 1, name: 'HTML'),
  ];

  void selectSkill(val, context) {
    selectedSkills = val;
    emit(ApplicantSelectSkillsState());
  }
}
