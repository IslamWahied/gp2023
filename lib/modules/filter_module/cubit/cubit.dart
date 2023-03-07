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
import 'package:intl/intl.dart';

import '../../../models/Filter_model.dart';
import '../../applicant_home_module/cubit/cubit.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(FilterInitialState());

  static FilterCubit get(context) => BlocProvider.of(context);


  var city = "Cairo";
  var country = "Egypt";
  var nationality = "Egyptian";
  var jopTitle="front end web Developer";
  var grade="Excellence";

  var formKey = GlobalKey<FormState>();
  TextEditingController fromDateTimeController = TextEditingController();
  TextEditingController toDateTimeController = TextEditingController();
  var salaryExpectationsController = TextEditingController();
  var salaryFromController = TextEditingController();
  var salaryToController = TextEditingController();



   void filter(context) async {

   // print(jopTitle);
   // print(country);
   // print(city);
   // print(fromDateTimeController.text);
   // print(toDateTimeController.text);
   // print(salaryExpectationsController.text);

  ApplicantRegisterCubit.get(context).changeListFromFilter(
       jobTitle : jopTitle,
      country : jopTitle,
      city : jopTitle,
      fromDate :fromDateTimeController.text,
      toDate :fromDateTimeController.text,
       jobType : jopType,
       salary :double.parse(salaryExpectationsController.text),
       context :context
   );

   Navigator.pop(context);
  }
  void restFilter(context){

     city = "Cairo";
     country = "Egypt";
     nationality = "Egyptian";
     jopTitle="front end web Developer";
     grade="Excellence";

     formKey = GlobalKey<FormState>();
      fromDateTimeController.text = fromDateTimeController.text = DateFormat.yMMMd().format(DateTime.now()).toString();
      toDateTimeController.text = toDateTimeController.text = DateFormat.yMMMd().format(DateTime.now()).toString();
   salaryExpectationsController = TextEditingController();
   salaryFromController = TextEditingController();
   salaryToController = TextEditingController();
    ApplicantRegisterCubit.get(context).restListFromFilter();

    Navigator.pop(context);

  }

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

 String  jopType = "";
  double salaryFrom;
  double salaryTo;
  void filterApply(BuildContext context, {double salaryfrom, double salaryto, String companyName}) {
    salaryFrom = salaryfrom;
    salaryTo = salaryto;

    ApplicantRegisterCubit.get(context).searchList=[];

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
