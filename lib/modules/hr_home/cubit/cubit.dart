import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_home_module/cubit/states.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantRegisterCubit extends Cubit<ApplicantRegisterStates> {
  ApplicantRegisterCubit() : super(ApplicantHomeInitialState());

  static ApplicantRegisterCubit get(context) => BlocProvider.of(context);
}
