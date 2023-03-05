// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/models/jopTitleModel.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_home_module/applicantHome.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
        var cubit = ApplicantCreateSkillsCubit.get(context);

        final skills = cubit.SkillsItems.map((element) =>
            MultiSelectItem<SkillsDataModel>(element, element.name)).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Skills',
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
                          'Add your Skills',
                          style: Theme.of(context).textTheme.bodyLarge.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        MultiSelectDialogField(
                          onConfirm: (val) {
                            // cubit.selectJopTitle(val, context);
                          },
                          title: const Text('Skills'),
                          buttonText: const Text(
                            'Skills',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
                          itemsTextStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          dialogWidth: MediaQuery.of(context).size.width * 0.7,
                          dialogHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          backgroundColor: Colors.blueGrey[50],
                          cancelText: const Text(
                            'CANCEL',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                          items: skills,
                          initialValue: cubit.selectedSkills,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            color: Colors.white38,
                            border: Border.all(
                              color: Colors.black54,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
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
