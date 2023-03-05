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
import '../applicant_create_Education/applicantCreateEducationHome.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FilterHome extends StatelessWidget {
  const FilterHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var salaryFromController = TextEditingController();
    var salaryToController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => FilterCubit(),
      child: BlocConsumer<FilterCubit, FilterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar( backgroundColor: Color(0xff1B75BC),
                  title: const Text('Filter' ,
                    style: TextStyle(color: Colors.white),)),
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
                              'Filter List',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                              controller: salaryFromController,
                              type: TextInputType.number,
                              suffix: Icons.currency_bitcoin,
                              validate: (String value) {},
                              label: 'Salary from'
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: salaryToController,
                              type: TextInputType.number,
                              onSubmit: (value) {},
                              label: 'Salary To',
                              prefix: Icons.currency_bitcoin,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultButton(
                              function: () {
                                FilterCubit.get(context).filterApply(context,
                                    salaryfrom:
                                        double.parse(salaryFromController.text),
                                    salaryto:
                                      double.parse(salaryFromController.text));
                                navigateTo(context, const ApplicantLayout());
                                {}
                              },
                              text: 'apply',
                              isUpperCase: true,
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
