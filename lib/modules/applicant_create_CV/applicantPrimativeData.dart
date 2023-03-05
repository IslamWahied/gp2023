// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../applicant_create_Education/applicantCreateEducationHome.dart';
import 'cubit/cubit.dart';

class ApplicantPrimativeDataHome extends StatelessWidget {
  const ApplicantPrimativeDataHome({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var jobTitleController = TextEditingController();
    var degreeController = TextEditingController();
    var dateTime = DateTime.now();
    var dateTimeController = TextEditingController();
    List<String> nationality = ['Egyptian', 'American'];
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

    final List<DropdownMenuItem<String>> _dropDownMenuItems = cities
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value,

            ),
          ),
        )
        .toList();
    final List<DropdownMenuItem<String>> _dropDownMenuItems2 = nationality
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    return BlocProvider(
      create: (BuildContext context) => ApplicantPrimativeDataCubit(),
      child: BlocConsumer<ApplicantPrimativeDataCubit,
          ApplicantPrimativeDataStates>(listener: (context, state) {
        if (state is ApplicantPrimativeDataErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is ApplicantPrimativeDataSuccessState &&
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
          appBar: AppBar(title: const Text('create CV',
            style: TextStyle(color: Colors.white,
              fontSize: 22,
            ),
          ),
              backgroundColor: Color(0xff1B75BC),
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Details',

                        style: Theme.of(context).textTheme.bodyLarge.copyWith(
                            color:Colors.grey,

                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      defaultFormField(
                        controller: jobTitleController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your job title';
                          }
                        },
                        label: 'Job Title',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: degreeController,
                        type: TextInputType.number,
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            // ApplicantPrimativeDataCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                          }
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter Value';
                          }
                        },
                        label: 'Grade',
                        prefix: Icons.grade,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        title: const Text('What is your City? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),

                        trailing: DropdownButton<String>(
                          // Must be one of items.value.
                          value:
                              ApplicantPrimativeDataCubit.get(context).city,
                          onChanged: (String newValue) {
                            if (newValue != null) {
                              ApplicantPrimativeDataCubit.get(context)
                                  .changeCityState(newValue);
                            }
                          },
                          items: _dropDownMenuItems,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: const Text('What is nationality?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),

                        ),

                        trailing: DropdownButton<String>(
                          // Must be one of items.value.
                          value: ApplicantPrimativeDataCubit.get(context)
                              .nationality,
                          onChanged: (String newValue) {
                            if (newValue != null) {
                              ApplicantPrimativeDataCubit.get(context)
                                  .changeNationalityState(newValue);
                            }
                          },
                          items: _dropDownMenuItems2,
                        ),
                      ),
                      defaultFormField(
                        controller: dateTimeController,
                        type: TextInputType.datetime,
                        prefix: Icons.calendar_month,
                        label: "date of birth",
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse('1970-05-03'),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            dateTimeController.text =
                                DateFormat.yMMMd().format(value).toString();
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Center(
                        child:
                        defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ApplicantPrimativeDataCubit.get(context).cvCreate(
                                  jobTitle: jobTitleController.text,
                                  degree: degreeController.text,
                                  city: ApplicantPrimativeDataCubit.get(context)
                                      .city,
                                  nationality:
                                      ApplicantPrimativeDataCubit.get(context)
                                          .nationality,
                                  dateOfBirth: dateTime,
                                  gender: "Male",
                                  uId: CacheHelper.getData(key: 'uId'));
                              navigateTo(
                                  context, ApplicantCreateEducationHome());
                            }


                          },
                          text: 'next',
                          background: Color(0xff1B75BC),
                          radius: 50,
                          width: 200,
                          isUpperCase: true,
                        ),

                      ),
                    ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
