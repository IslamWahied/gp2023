// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/cubit.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_home_module/applicantHome.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../applicant_create_Education/applicantCreateEducationHome.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FilterHome extends StatelessWidget {
  const FilterHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    List<String> countries = [
      "United States",
      "Canada",
      "Afghanistan",
      "Albania",
      "Algeria",
      "American Samoa",
      "Andorra",
      "Angola",
      "Anguilla",
      "Antarctica",
      "Antigua and/or Barbuda",
      "Argentina",
      "Armenia",
      "Egypt"
    ];
    List<String> jopTitles = ['IT', 'HR'];
    List<String> employeeType = ['All', 'Remote',"Permanent","Contract"];
    List<String> grades = ['Excellence'];
    final List<DropdownMenuItem<String>> jopTitleDropDownMenuItems =
        jopTitles.map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
        ).toList();


    final List<DropdownMenuItem<String>> locationDropDownMenuItems =
    cities.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
    ).toList();


    final List<DropdownMenuItem<String>> countryDropDownMenuItems =
    countries.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
    ).toList();


    var formKey = GlobalKey<FormState>();

    var salaryFromController = TextEditingController();
    var salaryToController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => FilterCubit(),
      child: BlocConsumer<FilterCubit, FilterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var filterCubit = FilterCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                  leadingWidth: 60,
                  automaticallyImplyLeading: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 12, left: 15, right: 8),
                    child: MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    'Filter By',
                    style: TextStyle(color: Colors.grey[700]),
                  )),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jop Title',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultDropDownList(
                              filterCubit.jopTitle,
                              (value) => filterCubit.changeJopTitleState(value),
                              jopTitleDropDownMenuItems),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Location',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Country',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    defaultDropDownList(
                                        filterCubit.country,
                                        (value) => filterCubit.changeCountryTitleState(value),
                                        countryDropDownMenuItems),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('City',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    defaultDropDownList(
                                        filterCubit.city,
                                            (value) => filterCubit.changeCityTitleState(value),
                                        locationDropDownMenuItems),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text('Date',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    defaultFormField(
                                      //    controller: dateTimeController,
                                      type: TextInputType.datetime,
                                      prefix: Icons.calendar_month,
                                      label: "date of birth",
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime.parse('1970-05-03'),
                                          lastDate: DateTime.now(),
                                        ).then((value) {
                                          // dateTimeController.text =
                                          //     DateFormat.yMMMd().format(value).toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('To',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    defaultFormField(
                                      //    controller: dateTimeController,
                                      type: TextInputType.datetime,
                                      prefix: Icons.calendar_month,
                                      label: "date of birth",
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime.parse('1970-05-03'),
                                          lastDate: DateTime.now(),
                                        ).then((value) {
                                          // dateTimeController.text =
                                          //     DateFormat.yMMMd().format(value).toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          MultiSelectChipField<String>(

                            decoration: BoxDecoration(

                              border: Border.all(width: 0.5), // 0.1 to 0.9
                              // color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            title:   Text('Employment Type',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold)),
                            headerColor: Colors.transparent,

                            items: employeeType.map((e) => MultiSelectItem(e, e)).toList(),
                            chipColor: Colors.grey[200],
                            selectedChipColor: Colors.grey[200],
                            textStyle: TextStyle(color: Colors.black,fontSize: 15),
                            scroll: false,
                            selectedTextStyle: TextStyle(color: Colors.blue,fontSize: 8),
                            icon: const Icon(Icons.check,color: Colors.blue),
                            onTap: (values) {
                               var selectedValue = values.toString().replaceAll('[', '');
                               selectedValue = selectedValue.toString().replaceAll(']', '');
                              if (selectedValue != null && selectedValue.trim() != '') {
                                print(selectedValue.toString());
                                filterCubit.employeeType = selectedValue.toString();
                               }
                            },
                          )
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
