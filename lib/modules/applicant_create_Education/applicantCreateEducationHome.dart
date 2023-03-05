// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp2023/modules/applicant_create_Experience/applicantCreateEducationHome.dart';

import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantCreateEducationHome extends StatelessWidget {
  const ApplicantCreateEducationHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var educationLevelController = TextEditingController();
    var facultyController = TextEditingController();
    var startdateTimeController = TextEditingController();
    var enddateTimeController = TextEditingController();
    List<String> uniList = [
      "Cairo University",
      "Mansoura University",
      "Ain Shams University",
      "Alexandria University",
      "Kafrelsheikh University",
      "AAST",
      "Al Azhar University",
      "MTI",
      "MSA",
      "Modern Academy"
    ];
    List<String> cities = [
      "Cairo",
      "Alexandria",
      "Gizeh",
      "Shubra El-Kheima",
      "Port Said",
      "Suez",
      "Luxor",
      "al-Mansura",
      "El-Mahalla El-Kubra",
      "Tanta",
      "Asyut",
      "Ismailia",
      "Fayyum",
      "Zagazig",
      "Aswan",
      "Damietta",
      "Damanhur",
      "al-Minya",
      "Beni Suef",
      "Qena",
      "Sohag",
      "Hurghada",
      "6th of October City",
      "Shibin El Kom",
      "Banha",
      "Kafr el-Sheikh",
      "Arish",
      "Mallawi",
      "10th of Ramadan City",
      "Bilbais",
      "Marsa Matruh",
      "Idfu",
      "Mit Ghamr",
      "Al-Hamidiyya",
      "Desouk",
      "Qalyub",
      "Abu Kabir",
      "Kafr el-Dawwar",
      "Girga",
      "Akhmim",
      "Matareya"
    ];
    List<String> educationLevels = ["Master", "Doctor"];
    List<String> faculties = ["computer", "Engineer"];

    final List<DropdownMenuItem<String>> dropDownMenuItems2 = uniList
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    final List<DropdownMenuItem<String>> educationLevelDropDownMenuItems2 =
        educationLevels
            .map(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList();

    final List<DropdownMenuItem<String>> facultiesDropDownMenuItems2 = faculties
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    return BlocProvider(
      create: (BuildContext context) => ApplicantCreateEducationCubit(),
      child: BlocConsumer<ApplicantCreateEducationCubit,
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
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Education',
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
                  key: formKey,
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

                        SizedBox(
                          child: defaultDropDownList(
                              ApplicantCreateEducationCubit.get(context)
                                  .educationLevel, (value) {
                            if (value != null) {
                              ApplicantCreateEducationCubit.get(context)
                                  .changeEducationLevelState(value);
                            }
                          }, educationLevelDropDownMenuItems2),
                        ),

                        // defaultFormField(
                        //   controller: educationLevelController,
                        //   type: TextInputType.text,
                        //   validate: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'please enter your education level';
                        //     }
                        //   },
                        //   label: 'Education Level',
                        //   prefix: Icons.school,
                        // ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        defaultDropDownList(
                            ApplicantCreateEducationCubit.get(context).faculty,
                            (value) {
                          if (value != null) {
                            ApplicantCreateEducationCubit.get(context)
                                .changeFacultyState(value);
                          }
                        }, facultiesDropDownMenuItems2),

                        // defaultFormField(
                        //   controller: facultyController,
                        //   type: TextInputType.text,
                        //   onSubmit: (value) {
                        //     if (formKey.currentState.validate()) {
                        //       // ApplicantCreateEducationCubit.get(context).userLogin(
                        //       //   email: emailController.text,
                        //       //   password: passwordController.text,
                        //       // );
                        //     }
                        //   },
                        //   validate: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'enter Value';
                        //     }
                        //   },
                        //   label: 'faculty',
                        //   prefix: Icons.grade,
                        // ),
                        const SizedBox(
                          height: 15,
                        ),

                        defaultDropDownList(
                            ApplicantCreateEducationCubit.get(context)
                                .university, (value) {
                          if (value != null) {
                            ApplicantCreateEducationCubit.get(context)
                                .changeNationalityState(value);
                          }
                        }, dropDownMenuItems2),

                        const SizedBox(
                          height: 15.0,
                        ),

                        // ListTile(
                        //   title: const Text('What is university?'),
                        //   trailing: DropdownButton<String>(
                        //     // Must be one of items.value.
                        //     value: ApplicantCreateEducationCubit.get(context)
                        //         .university,
                        //     onChanged: (String newValue) {
                        //       if (newValue != null) {
                        //         ApplicantCreateEducationCubit.get(context)
                        //             .changeNationalityState(newValue);
                        //       }
                        //     },
                        //     items: _dropDownMenuItems2,
                        //   ),
                        // ),
                        defaultFormField(
                          controller: startdateTimeController,
                          type: TextInputType.datetime,
                          prefix: Icons.calendar_month,
                          label: "start date",
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse('1990-05-03'),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              startdateTimeController.text =
                                  DateFormat.yMMMd().format(value).toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: enddateTimeController,
                          type: TextInputType.datetime,
                          prefix: Icons.calendar_month,
                          label: "end date",
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse('1990-05-03'),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              enddateTimeController.text =
                                  DateFormat.yMMMd().format(value).toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ApplicantCreateEducationCubit.get(context)
                                    .EducationCreate(
                                        educationLevel:
                                            educationLevelController.text,
                                        faculty: facultyController.text,
                                        university:
                                            ApplicantCreateEducationCubit.get(
                                                    context)
                                                .university,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(context,
                                    const ApplicantCreateEducationHome());
                                educationLevelController =
                                    TextEditingController();
                                facultyController = TextEditingController();
                                startdateTimeController =
                                    TextEditingController();
                                enddateTimeController = TextEditingController();
                              }
                              {}
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
                              if (formKey.currentState.validate()) {
                                ApplicantCreateEducationCubit.get(context)
                                    .EducationCreate(
                                        educationLevel:
                                            ApplicantCreateEducationCubit.get(
                                                    context)
                                                .educationLevel,
                                        faculty: ApplicantCreateEducationCubit
                                                .get(context)
                                            .faculty,
                                        university:
                                            ApplicantCreateEducationCubit.get(
                                                    context)
                                                .university,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(context,
                                    const ApplicantCreateExperienceHome());
                              }
                              {}
                            },
                            text: 'Save and Continue',
                            background: const Color(0xff1B75BC),
                            radius: 50,
                            width: 300,
                            isUpperCase: true,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
