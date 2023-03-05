// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/CVModel.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';

import '../../../models/EducationModel.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantPrimativeDataCubit extends Cubit<ApplicantPrimativeDataStates> {
  var city = "Cairo";
  var nationality = "Egyptian";
  ApplicantPrimativeDataCubit() : super(ApplicantPrimativeDataInitialState());

  static ApplicantPrimativeDataCubit get(context) => BlocProvider.of(context);
  void cvCreate(
      {@required String jobTitle,
      @required String degree,
      @required String city,
      @required String gender,
      @required String nationality,
      @required DateTime dateOfBirth,
      @required String uId}) {
    CVModel model = CVModel(
        city: city,
        degree: degree,
        gender: gender,
        nationality: nationality,

        dateOfBirth: dateOfBirth,
        jobTitle: jobTitle,
        uId: uId);
    saveCVData(model);
  }

  void saveCVData(CVModel M) {
    FirebaseFirestore.instance.collection('cv').add(M.toMap()).then((value) {
      emit(ApplicantPrimativeDataSuccessState(M.uId));
    }).catchError((error) {
      emit(ApplicantPrimativeDataErrorState(error.toString()));
    });
  }

  void changeCityState(String cityOut) {
    city = cityOut;
    emit(ApplicantPrimativeDataChangeCityState());
  }

  void changeNationalityState(String nationality) {
    nationality = nationality;
    emit(ApplicantPrimativeDataChangeNationalityState());
  }

}


