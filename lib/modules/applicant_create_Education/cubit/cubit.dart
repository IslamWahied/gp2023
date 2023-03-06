// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/EducationModel.dart';
import 'package:gp2023/modules/applicant_create_Education/cubit/states.dart';

import '../../applicant_create_CV/cubit/states.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantCreateEducationCubit
    extends Cubit<ApplicantCreateEducationStates> {
  var educationLevel = "Masters";
  var faculty = "computer science";
  var university = "MTI";
  ApplicantCreateEducationCubit()
      : super(ApplicantCreateEducationInitialState());

  static ApplicantCreateEducationCubit get(context) => BlocProvider.of(context);
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
    university = cityOut;
    emit(ApplicantCreateEducationChangeCityState());
  }

  void changeNationalityState(String nationalityOut) {
    university = nationalityOut;
    emit(ApplicantCreateEducationChangeNationalityState());
  }



  void changeEducationLevelState(String educationLevelValue) {
    educationLevel = educationLevelValue;
    emit(ApplicantCreateEducationChangeeducationLevelState());
  }

  void changeFacultyState(String facultyValue) {
    faculty = facultyValue;
    emit(ApplicantCreateEducationChangeFacultyState());
  }










}
class ApplicantPrimativeDataCubit2 extends Cubit<ApplicantPrimativeDataStates> {

  var faculty = "MTI univeristy";
  ApplicantPrimativeDataCubit2() : super(ApplicantPrimativeDataInitialState());

  static ApplicantPrimativeDataCubit2 get(context) => BlocProvider.of(context);
  void cvCreate(
      {
        @required educationLevel,
        @required String university,
        @required String faculty,
        @required String startDate,
        @required String endDate,
        @required String uId,}) {
    EducationModel model = EducationModel(
      university: university,
      faculty: faculty,
      startDate: startDate,
      uId: uId,



    );
    saveCVData(model as EducationModel);
  }

  void saveCVData(EducationModel M) {
    FirebaseFirestore.instance.collection('Education').add(M.toMap()).then((value) {
      emit(ApplicantPrimativeDataSuccessState(M.uId));
    }).catchError((error) {
      emit(ApplicantPrimativeDataErrorState(error.toString()));
    });
  }

  void changeCityState(String facultyout) {
    faculty = facultyout;
    emit(ApplicantPrimativeDataChangeCityState());
  }



}