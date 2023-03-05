// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/cubit/states.dart';
import 'package:gp2023/modules/applicant_Saved_module/AppState.dart';
import 'package:gp2023/modules/applicant_app_states_module/AppState.dart';
import 'package:gp2023/modules/applicant_home_module/applicantHome.dart';



class ApplicantCubit extends Cubit<ApplicantStates> {
  ApplicantCubit() : super(ApplicantInitialState());

  static ApplicantCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  //ApplicantUserModel model;
  void getApplicantString() {
    emit(ApplicantUserStringState());
  }

  List<Widget> screens = [
    const ApplicantHome(),
    const ApplicantAppStateHome(),
    const ApplicantSavedHome()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ApplicantChangeBottomNavBarState());
  }
}
