// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // var positionController = TextEditingController();
    var startdateTimeController = TextEditingController();
    var enddateTimeController = TextEditingController();

    List<String> positions = ["Team leader", "Manager"];
    final List<DropdownMenuItem<String>> positionDropDownMenuItems2 = positions
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

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
          appBar: AppBar(
            title: const Text(
              'Add Experience',
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

                        const Text('Position',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff1B75BC),
                                fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          child: defaultDropDownList(
                              ApplicantCreateExperienceCubit.get(context)
                                  .position, (value) {
                            if (value != null) {
                              ApplicantCreateExperienceCubit.get(context)
                                  .changePositionState(value);
                            }
                          }, positionDropDownMenuItems2),
                        ),

                        // defaultFormField(
                        //   controller: positionController,
                        //   type: TextInputType.text,
                        //   validate: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'enter Value';
                        //     }
                        //   },
                        //   label: 'position',
                        //   prefix: Icons.post_add_outlined,
                        // ),
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
                                        position:
                                            ApplicantCreateExperienceCubit.get(
                                                    context)
                                                .position,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(context,
                                    const ApplicantCreateExperienceHome());

                                startdateTimeController =
                                    TextEditingController();
                                enddateTimeController = TextEditingController();
                              }
                              {}
                            },
                            text: 'Save and Add Another Experience',
                            background: const Color(0xff1B75BC),
                            radius: 50,
                            width: 300,
                            isUpperCase: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ApplicantCreateExperienceCubit.get(context)
                                    .ExperienceCreate(
                                        companyName: companyNameController.text,
                                        position:
                                            ApplicantCreateExperienceCubit.get(
                                                    context)
                                                .position,
                                        endDate: enddateTimeController.text,
                                        startDate: startdateTimeController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(
                                    context, const ApplicantCreateSkillsHome());
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
