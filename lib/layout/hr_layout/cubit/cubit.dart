// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/hr_layout/cubit/states.dart';
import 'package:gp2023/models/job_model.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

import '../../../modules/hr_application/HrApplication.dart';
import '../../../modules/hr_home/hrHome.dart';

class HrCubit extends Cubit<HrStates> {
  HrCubit() : super(HrInitialState());

  static HrCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  //HrUserModel model;
  void getHrString() {
    emit(HrUserStringState());
  }

  bool isBottomSheetShown = false;

  List<Widget> screens = [
    const HrHome(),
    const HrApplication(),
  ];
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(HrChangeBottomNavBarState());
  }

  job_model jobModel;
  void createJob(
      {String jobTitle,
      String jobDescription,
      String type,
      int salary,
      String role,
      DateTime startDate}) {
    jobModel.jobTitle = jobTitle;
    jobModel.description = jobDescription;
    jobModel.type = type;
    jobModel.salary = salary;
    jobModel.role = role;
    jobModel.startDate = startDate;
    jobModel.uId = CacheHelper.getData(key: 'uId');
  }

  void saveJob(job_model jobModel) {
    FirebaseFirestore.instance
        .collection('c.v')
        .add(jobModel.toMap())
        .then((value) {
      showToast(text: 'saved successfully', state: ToastStates.SUCCESS);
      emit(HrSaveSuccessState());
    }).catchError((error) {
      emit(HrGetUserErrorState(error.toString()));
    });
  }
}
