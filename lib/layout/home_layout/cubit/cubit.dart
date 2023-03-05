// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/home_layout/cubit/states.dart';
import 'package:gp2023/models/user_model.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

class WorkableCubit extends Cubit<WorkableStates> {
  WorkableCubit() : super(WorkableInitialState());

  static WorkableCubit get(context) => BlocProvider.of(context);

  WorkableUserModel model;

  void getUserData() {
    emit(WorkableGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('Applicant')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      model = WorkableUserModel.fromJson(value.data());
      emit(WorkableGetUserSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(WorkableGetUserErrorState(error.toString()));
    });
  }

  void updateIsEmailVerified() {
    FirebaseFirestore.instance
        .collection('Applicant')
        .doc(CacheHelper.getData(key: 'uId'))
        .update({"isEmailVerified": true})
        .then((value) => emit(WorkableUpdateIsEmailVerified()))
        .catchError((error) {
          //print(error.toString());
          emit(WorkableGetUserErrorState(error.toString()));
        });
  }
}
