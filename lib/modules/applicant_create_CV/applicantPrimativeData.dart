// ignore: file_names
// @dart=2.9

// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_Education/applicantCreateEducationHome.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/components/constants.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'cubit/cubit.dart';

class ApplicantPrimativeDataHome extends StatelessWidget {
  const ApplicantPrimativeDataHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicantPrimativeDataCubit,
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
      var cubit = ApplicantPrimativeDataCubit.get(context);

      final List<DropdownMenuItem<String>> citiesDropDownMenuItems = citiesList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> nationalityDropDownMenuItems2 =
          nationalityList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      final List<DropdownMenuItem<String>> jopTitleDropDownMenuItems2 =
          jopTitlesList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      final List<DropdownMenuItem<String>> genderDropDownMenuItems2 = genderList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> gradeDropDownMenuItems2 = gradesList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> countryDropDownMenuItems2 =
          countriesList
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
            'My CV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff1B75BC),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Details',
                      style: Theme.of(context).textTheme.bodyLarge.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // Name
                    dropDownListTitle('Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: defaultFormField(
                          controller: cubit.nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          suffix: Icons.person,
                          prefix: null),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Email

                    dropDownListTitle('Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: defaultFormField(
                          controller: cubit.emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          suffix: Icons.email,
                          prefix: null),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Phone

                    dropDownListTitle('Phone'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: defaultFormField(
                          controller: cubit.phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          suffix: Icons.phone,
                          prefix: null),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Gender

                    dropDownListTitle('Gender'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.genderValue,
                        (value) => cubit.changeGenderState(value),
                        genderDropDownMenuItems2),
                    const SizedBox(
                      height: 10,
                    ),

                    // Jop Title

                    dropDownListTitle('Jop Title'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.jopTitleValue2,
                        (value) => cubit.changeJopTitleState(value),
                        jopTitleDropDownMenuItems2),
                    const SizedBox(
                      height: 10,
                    ),

                    // Grade

                    dropDownListTitle('Grade'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.gradeValue,
                        (value) => cubit.changeGradeState(value),
                        gradeDropDownMenuItems2),
                    const SizedBox(
                      height: 10,
                    ),

                    // Country

                    dropDownListTitle('Country'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.countriesValue,
                        (value) => cubit.changeCountryState(value),
                        countryDropDownMenuItems2),
                    const SizedBox(
                      height: 10,
                    ),

                    // City

                    dropDownListTitle('City'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.cityValue,
                        (value) => cubit.changeCityState(value),
                        citiesDropDownMenuItems),
                    const SizedBox(
                      height: 10,
                    ),

                    // Nationality

                    dropDownListTitle('Nationality'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultDropDownList(
                        cubit.nationalitiesValue,
                        (value) => cubit.changeNationalityState(value),
                        nationalityDropDownMenuItems2),
                    const SizedBox(
                      height: 15,
                    ),

                    // Date of birth

                    dropDownListTitle('Date of birth'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        child: defaultDateOfBirth(
                            cubit.dateTimeController, context, (value) {
                      cubit.dateTimeController.text =
                          DateFormat.yMMMd().format(value).toString();
                    },'Date of birth')),
                    const SizedBox(
                      height: 30,
                    ),

                    // Button

                    Center(
                      child: defaultButton(
                        function: () {
                          if (cubit.formKey.currentState.validate()) {
                            cubit.cvCreate(
                                jobTitle: cubit.jopTitleValue2,
                                degree: cubit.gradeValue,
                                city: cubit.cityValue,
                                nationality: cubit.nationalitiesValue,
                                dateOfBirth: cubit.dateTime,
                                uId: CacheHelper.getData(key: 'uId'),
                                name: cubit.nameController.text.toString(),
                                phone: cubit.phoneController.text.toString(),
                                email: cubit.emailController.text.toString(),
                                gender: cubit.genderValue.toString());
                            navigateTo(
                                context, const ApplicantCreateEducationHome());
                          }
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
      );
    });
  }
}
