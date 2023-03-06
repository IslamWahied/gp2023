// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/CVModel.dart';
import 'package:gp2023/models/jopTitleModel.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

import '../../../models/EducationModel.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantPrimativeDataCubit extends Cubit<ApplicantPrimativeDataStates> {
  var city = "Cairo";
  var country = "Egypt";
  var nationality = "Egyptian";
  var jopTitle="IT";
  var grade="Excellence";
  ApplicantPrimativeDataCubit() : super(ApplicantPrimativeDataInitialState());

  static ApplicantPrimativeDataCubit get(context) => BlocProvider.of(context);
  void cvCreate(
      {@required String jobTitle,
      @required String degree,
      @required String city,

      @required String nationality,
      @required DateTime dateOfBirth,
      @required String uId}) {





  bool isMale =   CacheHelper.getData(key: 'isMale');

  String gender = isMale? "Male":"Female";

    CVModel model = CVModel(
        city: city,
        name : CacheHelper.getData(key: "name"),
        phone :CacheHelper.getData(key: "phone"),
        email :CacheHelper.getData(key: "email"),
        degree: degree,
        gender: gender,
        nationality: nationality,
        dateOfBirth: dateOfBirth,
        jobTitle: jobTitle,
        uId: uId
    );
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

  void changeCountryState(String country) {
    country = country;
    emit(ApplicantPrimativeDataChangeCountryState());
  }


  void changeNationalityState(String nationality) {
    nationality = nationality;
    emit(ApplicantPrimativeDataChangeNationalityState());
  }


  void changeJopTitleState(String JopTitle) {
    jopTitle = JopTitle;
    emit(ApplicantPrimativeDataChangeJopTitleState());
  }

  void changeGradeState(String Grade) {
    Grade = Grade;
    emit(ApplicantPrimativeDataChangeGradeState());
  }


  // List<JopTitleData> JopTitleItems = [
  //
  // ];
  // List<JopTitleData> selectedJopTitle = [];
  //
  // void selectJopTitle(val, context) {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //
  //   selectedJopTitle = val;
  //
  //   emit(ApplicantPrimativeDataChangeJopTitleState());
  // }




}


