// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/CVModel.dart';
import 'package:gp2023/models/jopTitleModel.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/shared/components/constants.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

import '../../../models/EducationModel.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantPrimativeDataCubit extends Cubit<ApplicantPrimativeDataStates> {
  var formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();
  var dateTimeController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();

  var cityValue = defaultDropDownListValue;
  var countriesValue = defaultDropDownListValue;
  var nationalitiesValue = defaultDropDownListValue;
  var jopTitleValue = defaultDropDownListValue;
  var genderValue = defaultDropDownListValue;
  var gradeValue = defaultDropDownListValue;

  ApplicantPrimativeDataCubit() : super(ApplicantPrimativeDataInitialState());

  static ApplicantPrimativeDataCubit get(context) => BlocProvider.of(context);

  void cvCreate(
      {@required String name,
      @required String phone,
      @required String email,
      @required String gender,
      @required String jobTitle,
      @required String degree,
      @required String city,
      @required String nationality,
      @required DateTime dateOfBirth,
      @required String uId}) {
    CVModel model = CVModel(
        city: city,
        name: name,
        phone: phone,
        email: email,
        degree: degree,
        gender: gender,
        nationality: nationality,
        dateOfBirth: dateOfBirth,
        jobTitle: jobTitle,
        uId: uId);
    saveCVData(model);
  }

  final List<CVModel> cvDataList = [];

  void setRegisterData() async {
    nameController.text = CacheHelper.getData(key: "name");
    phoneController.text = CacheHelper.getData(key: "phone");
    emailController.text = CacheHelper.getData(key: "email");
    bool isMale = CacheHelper.getData(key: 'isMale') ?? true;
    String gender = isMale ? "Male" : "Female";
    genderValue = gender;

    await FirebaseFirestore.instance.collection('cv').get().then(((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == uId) {
          CVModel model;

          model = CVModel.fromJson(element.data());
          cvDataList.add(model);
        }
      }
      jopTitleValue = cvDataList[0].jobTitle.toString() ?? '';
      cityValue = cvDataList[0].city.toString() ?? '';
      nationalitiesValue = cvDataList[0].nationality.toString() ?? '';
      dateTimeController.text = cvDataList[0].dateOfBirth.toString() ?? '';
      emit(ApplicantPrimativeDataGetCvDataState());

    }));
  }

  void saveCVData(CVModel M) {
    FirebaseFirestore.instance.collection('cv').add(M.toMap()).then((value) {
      emit(ApplicantPrimativeDataSuccessState(M.uId));
    }).catchError((error) {
      emit(ApplicantPrimativeDataErrorState(error.toString()));
    });
  }

  void changeCityState(String cityOut) {
    cityValue = cityOut;
    emit(ApplicantPrimativeDataChangeCityState());
  }

  void changeCountryState(String countryValue) {
    countriesValue = countryValue;
    emit(ApplicantPrimativeDataChangeCountryState());
  }

  void changeNationalityState(String nationalityValue) {
    nationalitiesValue = nationalityValue;
    emit(ApplicantPrimativeDataChangeNationalityState());
  }

  void changeJopTitleState(String JopTitleValue) {
    jopTitleValue = JopTitleValue;
    emit(ApplicantPrimativeDataChangeJopTitleState());
  }

  void changeGenderState(String GenderValue) {
    genderValue = GenderValue;
    emit(ApplicantPrimativeDataChangeGenderState());
  }

  void changeGradeState(String GradeValue) {
    gradeValue = GradeValue;
    emit(ApplicantPrimativeDataChangeGradeState());
  }
}
