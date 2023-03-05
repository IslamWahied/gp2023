// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_Skills/applicantCreateSkills.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantCreateExperienceHome extends StatelessWidget {
  const ApplicantCreateExperienceHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var companyNameController = TextEditingController();
    var positionController = TextEditingController();
    var startdateTimeController = TextEditingController();
    var enddateTimeController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ApplicantCreateExperienceCubit(),
      child: BlocConsumer<ApplicantCreateExperienceCubit,
          ApplicantCreateExperienceStates>(listener: (context, state) {
        if (state is ApplicantCreateExperienceErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is ApplicantCreateExperienceSuccessState &&
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
          appBar: AppBar(title: const Text('Add Experience',
            style: TextStyle(color: Colors.white,
              fontSize: 22,
            ),
          ),
            backgroundColor: Color(0xff1B75BC),
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
                          'Add your Experience data',
                          style: Theme.of(context).textTheme.bodyLarge.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: companyNameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your company Name';
                            }
                          },
                          label: 'Company Name',
                          prefix: Icons.school,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: positionController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'enter Value';
                            }
                          },
                          label: 'position',
                          prefix: Icons.post_add_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                                ApplicantCreateExperienceCubit.get(context)
                                    .ExperienceCreate(
                                        companyName: companyNameController.text,
                                        position: positionController.text,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(
                                    context, ApplicantCreateExperienceHome());
                                companyNameController = TextEditingController();
                                positionController = TextEditingController();
                                startdateTimeController = TextEditingController();
                                enddateTimeController = TextEditingController();
                              }
                              {}
                            },
                            text: 'Save and Add Another Experience',
                            background: Color(0xff1B75BC),
                            radius: 50,
                            width: 300,
                            isUpperCase: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ApplicantCreateExperienceCubit.get(context)
                                    .ExperienceCreate(
                                        companyName: companyNameController.text,
                                        position: positionController.text,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(context, ApplicantCreateSkillsHome());
                              }
                              {}
                            },
                            text: 'Save and Continue',
                            background: Color(0xff1B75BC),
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
