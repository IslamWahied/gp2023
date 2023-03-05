// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/styles/colors.dart';
import 'package:intl/intl.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HrLayout extends StatelessWidget {
  const HrLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var jobtitleController = TextEditingController();
    var jobDescriptionController = TextEditingController();
    var jobTypeController = TextEditingController();
    var salaryController = TextEditingController();
    var roleController = TextEditingController();
    var startDateController = TextEditingController();
    return BlocConsumer<HrCubit, HrStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // String appBarText =
          //  CacheHelper.getData(key: 'name') + ' !' ?? 'hi, User!';
          return Scaffold(
            body:
                HrCubit.get(context).screens[HrCubit.get(context).currentIndex],
            drawer: initiateDrawer(context),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: HrCubit.get(context).currentIndex,
              onTap: (index) {
                HrCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.file_copy_outlined,
                  ),
                  label: 'Applications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.hearing,
                  ),
                  label: 'Third tab',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryAppColor,
              child: Icon(HrCubit.get(context).fabIcon),
              onPressed: () {
                if (HrCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    HrCubit.get(context).createJob(
                        jobTitle: jobtitleController.text,
                        jobDescription: jobDescriptionController.text,
                        type: jobTypeController.text,
                        salary: int.parse(salaryController.text),
                        startDate: DateTime.parse(startDateController.text),
                        role: roleController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: jobtitleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                    },
                                    label: 'Job Title',
                                    prefix: Icons.title,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: jobDescriptionController,
                                    type: TextInputType.text,
                                    maxLine: 12,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'description must not be empty';
                                      }
                                    },
                                    label: 'Job Description',
                                    prefix: Icons.line_style,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: jobTypeController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'job type must not be empty';
                                      }
                                    },
                                    label: 'Job Type',
                                    prefix: Icons.type_specimen,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                      controller: salaryController,
                                      type: TextInputType.number,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'job salary must not be empty';
                                        }
                                      },
                                      label: 'Job Salary in EGP',
                                      prefix: Icons.currency_bitcoin),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: roleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'job role must not be empty';
                                      }
                                    },
                                    label: 'Job Role',
                                    prefix: Icons.work,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: startDateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime(2000),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        startDateController.text =
                                            DateFormat.yMMMd()
                                                .format(value)
                                                .toString();
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'Date must not be empty';
                                      }
                                    },
                                    label: 'Start Date',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                ]),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    HrCubit.get(context).changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });

                  HrCubit.get(context).changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
            ),
          );
        });
  }
}
