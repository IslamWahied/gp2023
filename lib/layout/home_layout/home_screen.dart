// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/applicant_layout/applicant_layout.dart';
import 'package:gp2023/layout/home_layout/ask_create_cv.dart';
import 'package:gp2023/layout/home_layout/cubit/states.dart';
import 'package:gp2023/layout/home_layout/cubit/cubit.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';




class WorkableLayout extends StatelessWidget {
  const WorkableLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkableCubit, WorkableStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: WorkableCubit.get(context).model != null,
            builder: (context) {
              // var model = FirebaseAuth.instance.currentUser.emailVerified;

              return Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Image(
                    image: AssetImage('assets/images/start.jpg'),
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Explore and find the best career for you!',
                    style: TextStyle(
                        color: HexColor('#000000'),
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HexColor('1B74BB'),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.06),
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.06),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.06,
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Prepare for and secure your ideal internship, placement, or graduate position.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: ElevatedButton(
                              onPressed: (){
                                navigateAndFinish(context, const AskCreateCvScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    color: HexColor('1B74BB'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget Columns(BuildContext context) {
    return Column(children: [
      const Image(
        image: AssetImage('assets/images/hang.png'),
        width: double.infinity,
        height: 300,
      ),
      const SizedBox(
        height: 30,
      ),
      defaultButton(
        function: () {
          navigateTo(context, const ApplicantLayout());
        },
        text: "save And Continue",
        background: const Color(0xff1B75BC),
        radius: 50,
        width: 300,
      )
    ]);
  }
}
