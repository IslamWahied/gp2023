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
  ApplicantRegisterCubit() : super(ApplicantHomeInitialState());
  // {
  //   // listofJobs = JobSearch().streamBuilder('', 'JobTitle');
  // //  listTempOfJobs = listMasterOfJobs;
  // }

  static ApplicantRegisterCubit get(context) => BlocProvider.of(context);

  void getApplicantRegisterString() {
    emit(ApplicantUserStringState());
  }
List<String> d = [];
  getAllJobs() async {
    FirebaseFirestore.instance.collection('Jobs').snapshots().listen((event) {
      listOfJobsMaster =event.docs.map((x) => JobModel.fromJson(x.data())).toList();
       listOfJobs = listOfJobsMaster;

      listOfJobs.forEach((element) {
        d.add(element.JobType);
      });

      print(d.toList().toSet().toList());
      emit(ApplicantHomeSearchState());
    });
  }

  void updateJobList(BuildContext context) {

  }

  int jobsCount;
  List<job_model> searchList;
 List<JobModel> listOfJobs = [];
 List<JobModel> listOfJobsMaster = [];
  //StreamBuilder<List<JobModel>> listofJobs;


void changeListSearch(String search, BuildContext context) {
  if (search.isEmpty) {
    listOfJobs = listOfJobsMaster;
  } else {
    listOfJobs = listOfJobsMaster.where((element) => (element.jobDescription + element.jobTitle + element.salary.toString() + element.JobType).toLowerCase().contains(search.toLowerCase())).toList();
    emit(ApplicantHomeSearchState());
  }
}

  void changeListFromFilter(
      {String jobTitle,
      String jobType,
      String city,
      String country,
      double salary,
      String fromDate,
      String jopType,
      String toDate,
      BuildContext context}) {


  // print(jobTitle);
  // print(jobType);
  // print(country);
  // print(city);
  //
  // print(salary);
  // print(fromDate);
  //
  // print(toDate);
    // if (search.isEmpty) {
    //   listOfJobs = listOfJobsMaster;
    // } else {
    DateTime startDate = DateTime.parse(fromDate);
    DateTime endDate = DateTime.parse(toDate);

    DateTime now = DateTime.now();

      listOfJobs = listOfJobsMaster.where((element) => element.jobTitle.toLowerCase() == jobTitle.toLowerCase() &&  element.salary.toString() == salary.toString() && jobType.contains(element.JobType)
          // &&
          // element.startDate.isAfter(startDate)
          // &&
          // element.endDate.isBefore(endDate)

      ).toList();

      emit(ApplicantHomeSearchState());
    // }
  }




  void restListFromFilter() {



    // if (search.isEmpty) {
    //   listOfJobs = listOfJobsMaster;
    // } else {
    listOfJobs = listOfJobsMaster.toList();
    emit(ApplicantHomeSearchState());
    // }
  }



  // void changeListSearch(String search, BuildContext context) {
  //   if (search.isEmpty) {
  //     listofJobs = JobSearch().streamBuilder('', 'JobTitle');
  //   } else {
  //     listofJobs = JobSearch().streamBuilder(search, 'JobTitle');
  //     emit(ApplicantHomeSearchState());
  //   }
  // }
}
