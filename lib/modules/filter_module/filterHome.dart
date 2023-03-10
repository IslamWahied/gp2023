// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/modules/applicant_app_states_module/cubit/states.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/cubit.dart';
import 'package:gp2023/modules/applicant_create_CV/cubit/states.dart';
import 'package:gp2023/modules/applicant_home_module/applicantHome.dart';
import 'package:gp2023/shared/components/constants.dart';
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


    final List<DropdownMenuItem<String>> jopTitleDropDownMenuItems =
    jopTitlesList.map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
        ).toList();


    final List<DropdownMenuItem<String>> locationDropDownMenuItems =
    citiesList.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
    ).toList();


    final List<DropdownMenuItem<String>> countryDropDownMenuItems =
    countriesList.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
    ).toList();


    var formKey = GlobalKey<FormState>();

    // var salaryFromController = TextEditingController();
    // var salaryToController = TextEditingController();

    return  BlocConsumer<FilterCubit, FilterStates>(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          height: 20,
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
                                    controller: filterCubit.fromDateTimeController,
                                    type: TextInputType.datetime,
                                    prefix: Icons.calendar_month,
                                    // label:DateFormat.yMMMd().format(DateTime.now()).toString()  ,
                                    validate:(value){
                                      if (value.isEmpty) {
                                        return 'please Select From Date';
                                      }
                                    } ,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.parse('1970-05-03'),
                                        lastDate: DateTime.parse('20100-05-03'),
                                      ).then((value) {
                                        if(value != null){
                                          filterCubit.fromDateTimeController.text = DateFormat.yMMMd().format(value).toString();
                                        }

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
                                    controller: filterCubit.toDateTimeController,
                                    type: TextInputType.datetime,
                                    prefix: Icons.calendar_month,
                                    validate:(value){
                                      if (value.isEmpty) {
                                        return 'please Select To Date';
                                      }
                                    } ,
                                    // label:DateFormat.yMMMd().format(DateTime.now()).toString()  ,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.parse('1970-05-03'),
                                        lastDate: DateTime.parse('20100-05-03'),


                                      ).then((value) {
                                        if(value != null){
                                          filterCubit.toDateTimeController.text = DateFormat.yMMMd().format(value).toString();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        MultiSelectChipField<String>(

                          decoration: BoxDecoration(

                            border: Border.all(width: 0.5), // 0.1 to 0.9
                            // color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          title:   Text('Jop Type',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold)),
                          headerColor: Colors.transparent,
                          validator:(value){
                            if (value.isEmpty) {
                              return 'please Select Jop Type';
                            }
                            else {
                              return null;
                            }

                          } ,
                          items: jopType.map((e) => MultiSelectItem(e, e)).toList(),
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
                              filterCubit.jopType = selectedValue.toString();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: filterCubit.salaryExpectationsController,
                          validator:(value) {
                            if (value.isEmpty) {
                              return 'please Select Salary expectations';
                            }else{
                              return null;
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                              hintText: "Salary expectations?",
                              hintStyle: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.w600)
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {

                                filterCubit.filter(context);

                              }
                            },
                            text: 'Apply',
                            background: const Color(0xff1B75BC),

                            radius: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            isUpperCase: false,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child:  Container(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                color: Colors.white,
                              ),
                              child: MaterialButton(
                                onPressed: (){

                                  filterCubit.restFilter(context);

                                },
                                child: const Text(
                                  "Reset",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}
