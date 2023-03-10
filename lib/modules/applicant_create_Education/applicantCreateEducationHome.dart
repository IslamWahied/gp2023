// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp2023/modules/applicant_create_Experience/applicantCreateExperienceHome.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/components/constants.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';

import 'package:intl/intl.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantCreateEducationHome extends StatelessWidget {
  const ApplicantCreateEducationHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicantCreateEducationCubit,
        ApplicantCreateEducationStates>(listener: (context, state) {
      if (state is ApplicantCreateEducationErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if (state is ApplicantCreateEducationSuccessState &&
          CacheHelper.getData(key: 'isApplicant') &&
          (CacheHelper.getData(key: 'email') != null ||
              CacheHelper.getData(key: 'name') != null)) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {});
      }
    }, builder: (context, state) {
      var cubit = ApplicantCreateEducationCubit.get(context);

      final List<DropdownMenuItem<String>> dropDownMenuItems2 = uniList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> educationLevelDropDownMenuItems2 =
          educationLevelsList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      final List<DropdownMenuItem<String>> facultiesDropDownMenuItems2 =
          facultiesList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Education',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff1B75BC),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add your education data',
                        style: Theme.of(context).textTheme.bodyLarge.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      //Education Level
                      dropDownListTitle('Education Level'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child: defaultDropDownList(cubit.educationLevelsValue,
                            (value) {
                          if (value != null) {
                            cubit.changeEducationLevelState(value);
                          }
                        }, educationLevelDropDownMenuItems2),
                      ),

                      //Faculty
                      const SizedBox(
                        height: 15.0,
                      ),
                      dropDownListTitle('Faculty'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child:
                            defaultDropDownList(cubit.facultiesValue, (value) {
                          if (value != null) {
                            cubit.changeFacultyState(value);
                          }
                        }, facultiesDropDownMenuItems2),
                      ),

                      //University

                      const SizedBox(
                        height: 15,
                      ),
                      dropDownListTitle('University'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child:
                            defaultDropDownList(cubit.universityValue, (value) {
                          if (value != null) {
                            cubit.changeNationalityState(value);
                          }
                        }, dropDownMenuItems2),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      //First date
                      SizedBox(
                          child: defaultDateOfBirth(
                              cubit.startDateTimeController, context, (value) {
                        cubit.startDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "start date")),
                      const SizedBox(
                        height: 15,
                      ),
                      //End date
                      SizedBox(
                          child: defaultDateOfBirth(
                              cubit.endDateTimeController, context, (value) {
                        cubit.endDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "end date")),

                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState.validate()) {
                              cubit.EducationCreate(
                                  educationLevel:
                                      cubit.educationLevelsValue,
                                  faculty: cubit.facultiesValue,
                                  university:
                                      ApplicantCreateEducationCubit.get(context)
                                          .universityValue,
                                  endDate: cubit.endDateTimeController.text,
                                  startDate: cubit.startDateTimeController.text,
                                  uId: CacheHelper.getData(key: 'uId'));

                              cubit.educationLevelsValue =defaultDropDownListValue;

                              cubit.facultiesValue = defaultDropDownListValue;
                              cubit.startDateTimeController =
                                  TextEditingController();
                              cubit.endDateTimeController =
                                  TextEditingController();
                            }

                          },
                          text: 'Save and Add Another Education',
                          isUpperCase: true,
                          background: const Color(0xff1B75BC),
                          radius: 50,
                          width: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState.validate()) {
                              cubit.EducationCreate(
                                  educationLevel:
                                      ApplicantCreateEducationCubit.get(context)
                                          .educationLevelsValue,
                                  faculty:
                                      ApplicantCreateEducationCubit.get(context)
                                          .facultiesValue,
                                  university:
                                      ApplicantCreateEducationCubit.get(context)
                                          .universityValue,
                                  endDate: cubit.endDateTimeController.text,
                                  startDate: cubit.startDateTimeController.text,
                                  uId: CacheHelper.getData(key: 'uId'));
                              navigateTo(context,
                                  const ApplicantCreateExperienceHome());
                            }
                            {}
                          },
                          text: 'next',
                          background: const Color(0xff1B75BC),
                          radius: 50,
                          width: 200,
                          isUpperCase: true,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
