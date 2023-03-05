// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/SkillsModel.dart';
import 'package:gp2023/modules/applicant_create_Skills/cubit/states.dart';
import 'package:gp2023/shared/components/components.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantCreateSkillsCubit extends Cubit<ApplicantCreateSkillsStates> {
  ApplicantCreateSkillsCubit() : super(ApplicantCreateSkillsInitialState());

  static ApplicantCreateSkillsCubit get(context) => BlocProvider.of(context);
  // ignore: non_constant_identifier_names
  void ExperienceCreate({@required String skillName, @required String uId}) {
    SkillModel model = SkillModel(skillName: skillName, uId: uId);
    saveSkillData(model);
  }

  void saveSkillData(SkillModel M) {
    FirebaseFirestore.instance
        .collection('Applicant Skills')
        .add(M.toMap())
        .then((value) {
      emit(ApplicantCreateSkillsSuccessState(M.uId));
      showToast(text: 'CV added successfully', state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(ApplicantCreateSkillsErrorState(error.toString()));
    });
  }
}
