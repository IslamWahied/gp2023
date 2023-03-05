// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_home_module/applicantHome.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantCreateSkillsHome extends StatelessWidget {
  const ApplicantCreateSkillsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var skillNameController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ApplicantCreateSkillsCubit(),
      child:
          BlocConsumer<ApplicantCreateSkillsCubit, ApplicantCreateSkillsStates>(
              listener: (context, state) {
        if (state is ApplicantCreateSkillsErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is ApplicantCreateSkillsSuccessState &&
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
          appBar: AppBar(title: const Text('Add Skills',
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
                          'Add your Skills',
                          style: Theme.of(context).textTheme.bodyLarge.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: skillNameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your skill';
                            }
                          },
                          label: 'skill Name',
                          prefix: Icons.arrow_upward_sharp,
                        ),
                        SizedBox(height: 25,),
                        Center(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ApplicantCreateSkillsCubit.get(context)
                                    .ExperienceCreate(
                                        skillName: skillNameController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                skillNameController = TextEditingController();
                                navigateTo(
                                    context, const ApplicantCreateSkillsHome());
                              }
                              {}
                            },
                            text: 'Save and Add Another Skill',
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
                                ApplicantCreateSkillsCubit.get(context)
                                    .ExperienceCreate(
                                        skillName: skillNameController.text,
                                        uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(context, const ApplicantLayout());
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
