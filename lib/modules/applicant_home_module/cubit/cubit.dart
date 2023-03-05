// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/JobSearch.dart';
import 'package:gp2023/modules/applicant_home_module/cubit/states.dart';
import 'package:gp2023/shared/jobs.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

import '../../../models/JobSearchModel.dart';
import '../../../models/job_model.dart';
import '../../filter_module/cubit/cubit.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantRegisterCubit extends Cubit<ApplicantRegisterStates> {
  ApplicantRegisterCubit() : super(ApplicantHomeInitialState()) {
    listofJobs = JobSearch().streamBuilder('', 'JobTitle');
  }

  static ApplicantRegisterCubit get(context) => BlocProvider.of(context);

  void getApplicantRegisterString() {
    emit(ApplicantUserStringState());
  }

  void updateJobList(BuildContext context) {}

  int jobsCount;
  List<job_model> searchList;
  StreamBuilder<List<JobModel>> listofJobs;

  void changeListSearch(String search, BuildContext context) {
    if (search.isEmpty) {
      listofJobs = JobSearch().streamBuilder('', 'JobTitle');
    } else {
      listofJobs = JobSearch().streamBuilder(search, 'JobTitle');
      emit(ApplicantHomeSearchState());
    }
  }
}
