// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/EducationModel.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_Education/cubit/states.dart';
import 'package:gp2023/shared/components/constants.dart';

class ApplicantCreateEducationCubit
    extends Cubit<ApplicantCreateEducationStates> {
  ApplicantCreateEducationCubit()
      : super(ApplicantCreateEducationInitialState());

  static ApplicantCreateEducationCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();


  var startDateTimeController = TextEditingController();
  var endDateTimeController = TextEditingController();

  var educationLevelsValue = defaultDropDownListValue;
  var facultiesValue = defaultDropDownListValue;
  var universityValue = defaultDropDownListValue;

  void EducationCreate(
      {@required String educationLevel,
      @required String university,
      @required String faculty,
      @required String startDate,
      @required String endDate,
      @required String uId}) {
    EducationModel model = EducationModel(
        educationLevel: educationLevel,
        university: university,
        faculty: faculty,
        startDate: startDate,
        endDate: endDate,
        uId: uId);
    saveEducationData(model);
  }

  void saveEducationData(EducationModel M) {
    FirebaseFirestore.instance
        .collection('Education')
        .add(M.toMap())
        .then((value) {
      emit(ApplicantCreateEducationSuccessState(M.uId));
    }).catchError((error) {
      emit(ApplicantCreateEducationErrorState(error.toString()));
    });
  }

  void changeCityState(String cityOut) {
    universityValue = cityOut;
    emit(ApplicantCreateEducationChangeCityState());
  }

  void changeNationalityState(String nationalityOut) {
    universityValue = nationalityOut;
    emit(ApplicantCreateEducationChangeNationalityState());
  }

  void changeEducationLevelState(String educationLevelValue) {
    educationLevelsValue = educationLevelValue;
    emit(ApplicantCreateEducationChangeeducationLevelState());
  }

  void changeFacultyState(String facultyValue) {
    facultiesValue = facultyValue;
    emit(ApplicantCreateEducationChangeFacultyState());
  }
}

class ApplicantPrimativeDataCubit2 extends Cubit<ApplicantPrimativeDataStates> {
  ApplicantPrimativeDataCubit2() : super(ApplicantPrimativeDataInitialState());

  static ApplicantPrimativeDataCubit2 get(context) => BlocProvider.of(context);

  void cvCreate({
    @required educationLevel,
    @required String university,
    @required String faculty,
    @required String startDate,
    @required String endDate,
    @required String uId,
  }) {
    EducationModel model = EducationModel(
      university: university,
      faculty: faculty,
      startDate: startDate,
      uId: uId,
    );
    saveCVData(model as EducationModel);
  }

  void saveCVData(EducationModel M) {
    FirebaseFirestore.instance
        .collection('Education')
        .add(M.toMap())
        .then((value) {
      emit(ApplicantPrimativeDataSuccessState(M.uId));
    }).catchError((error) {
      emit(ApplicantPrimativeDataErrorState(error.toString()));
    });
  }
}
