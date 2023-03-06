// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/models/jopTitleModel.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
    List<String> nationality = ['Egyptian',
      'American',
      'Canadian',
      'Russian',
      'Australian'
        'Bahamaian',
      'Brazilian',
      'French',
      'Greek'
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
    List<String> countries=  ["United States", "Canada", "Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and/or Barbuda", "Argentina", "Armenia", "Egypt"];
    List<String> jopTitles= [
      'IT',
      'HR',
      'Web Developer',
      'UX Designer & UI Developer',
      'Data Entry',
      'Information Security Analyst',
      'Artificial Intelligence Engineer',
      'Technical Specialist',
      'Graphic Designer',
      'Marketing Communications Manager',
      'Call Center',
      'Accounting Analyst',
      'Finance Manager',
      'Accountant',
      'Geological Engineer',
      'Maintenance Engineer',
      'Software Engineering'];
    List<String> grades= ['Excellent','Very Good','Good'];

    final List<DropdownMenuItem<String>> citiesDropDownMenuItems = cities
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          ),
        )
        .toList();
    final List<DropdownMenuItem<String>> nationalityDropDownMenuItems2 = nationality
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();





    final List<DropdownMenuItem<String>> jopTitleDropDownMenuItems2 = jopTitles
        .map(
          (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
        .toList();

    final List<DropdownMenuItem<String>> gradeDropDownMenuItems2 = grades
        .map(
          (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
        .toList();


    final List<DropdownMenuItem<String>> countryDropDownMenuItems2 = countries
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
      },
          builder: (context, state) {
            var cubit=ApplicantPrimativeDataCubit.get(context);
            // final jopTitle = cubit.JopTitleItems.map(
            //         (element) => MultiSelectItem<JopTitleData>(element, element.name)).toList();



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
                key: formKey,
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
                        height: 10.0,
                      ),



                      const Text(
                        'Jop Title',
                        style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultDropDownList(
                          ApplicantPrimativeDataCubit.get(context).jopTitle,
                              (value)=> ApplicantPrimativeDataCubit.get(context).changeJopTitleState(value),
                          jopTitleDropDownMenuItems2),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'Grade',
                          style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),

                      const SizedBox(
                        height: 10,
                      ),


                      defaultDropDownList(
                          ApplicantPrimativeDataCubit.get(context).grade,
                              (value)=> ApplicantPrimativeDataCubit.get(context).changeGradeState(value),
                          gradeDropDownMenuItems2),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'Country',
                          style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),


                      const SizedBox(
                        height: 10,
                      ),
                      defaultDropDownList(
                          ApplicantPrimativeDataCubit.get(context).country,
                              (value)=> ApplicantPrimativeDataCubit.get(context).changeCountryState(value),
                          countryDropDownMenuItems2),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'City',
                          style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),


                      const SizedBox(
                        height: 10,
                      ),
                      defaultDropDownList(
                          ApplicantPrimativeDataCubit.get(context).city,
                              (value)=> ApplicantPrimativeDataCubit.get(context).changeCityState(value),
                          citiesDropDownMenuItems),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'Nationality',
                          style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      defaultDropDownList(
                          ApplicantPrimativeDataCubit.get(context).nationality,
                              (value)=> ApplicantPrimativeDataCubit.get(context).changeNationalityState(value),
                          nationalityDropDownMenuItems2),

                      const SizedBox(
                        height: 15,
                      ),


                      const Text(
                          'Date of birth',
                          style:TextStyle(fontSize: 15,color: Color(0xff1B75BC),fontWeight: FontWeight.w700)
                      ),
                      const SizedBox(
                        height: 10,
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
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ApplicantPrimativeDataCubit.get(context).cvCreate(
                                  jobTitle: ApplicantPrimativeDataCubit.get(context).jopTitle,
                                  degree: ApplicantPrimativeDataCubit.get(context).grade,
                                  city: ApplicantPrimativeDataCubit.get(context)
                                      .city,
                                  nationality:
                                      ApplicantPrimativeDataCubit.get(context)
                                          .nationality,
                                  dateOfBirth: dateTime,

                                  uId: CacheHelper.getData(key: 'uId'));
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
      }),
    );
  }
}
