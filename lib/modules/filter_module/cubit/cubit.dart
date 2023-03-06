// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/CVModel.dart';
import 'package:gp2023/models/JobSearchModel.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/filter_module/cubit/states.dart';
import 'package:gp2023/shared/jobs.dart';

import '../../../models/Filter_model.dart';
import '../../applicant_home_module/cubit/cubit.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(FilterInitialState());

  static FilterCubit get(context) => BlocProvider.of(context);


  var city = "Cairo";
  var country = "Egypt";
  var nationality = "Egyptian";
  var jopTitle="IT";
  var grade="Excellence";

  var formKey = GlobalKey<FormState>();
  var salaryFromController = TextEditingController();
  var salaryToController = TextEditingController();


  void changeJopTitleState(String JopTitle) {
    jopTitle = JopTitle;
    emit(FilterApply());
  }
  void changeCityTitleState(String City) {
    city = City;
    emit(FilterApply());
  }

  void changeCountryTitleState(String Country) {
    print(country);
    country = Country;
    emit(FilterApply2());
  }

 String  employeeType = "";
  double salaryFrom;
  double salaryTo;
  void filterApply(BuildContext context, {double salaryfrom, double salaryto, String companyName}) {
    salaryFrom = salaryfrom;
    salaryTo = salaryto;

    ApplicantRegisterCubit.get(context).searchList=[];
    jobList.forEach((element) {




    });





















    //
    // FilterModel model = FilterModel(
    //     salaryFrom: salaryFrom, salaryTo: salaryTo, companyName: companyName);
    // if (model.salaryFrom != null || model.salaryFrom != 0) {
    //   List<JobModel> workingOn = ApplicantRegisterCubit.get(context).listofJobs as  List<JobModel>;
    //   workingOn =
    //       workingOn
    //           .where((element) => salaryFrom >= element.salary).toList();
    //   ApplicantRegisterCubit.get(context).listofJobs  = workingOn as StreamBuilder<List<JobModel>>;
    //
    // }
    // if (model.salaryTo != null || model.salaryTo != 0) {
    //   List<JobModel> workingOn = ApplicantRegisterCubit.get(context).listofJobs as  List<JobModel>;
    //   workingOn =
    //       workingOn
    //           .where((element) => element.salary <= salaryTo).toList();
    //   ApplicantRegisterCubit.get(context).listofJobs  = workingOn as StreamBuilder<List<JobModel>>;
    // }
    emit(FilterApply());
  }
}
