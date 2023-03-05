import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantAppStateRegisterCubit
    extends Cubit<ApplicantAppStateRegisterStates> {
  ApplicantAppStateRegisterCubit() : super(ApplicantAppStateHomeInitialState());

  static ApplicantAppStateRegisterCubit get(context) =>
      BlocProvider.of(context);
}
