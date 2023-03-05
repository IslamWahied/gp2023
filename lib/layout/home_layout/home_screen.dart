
// ignore_for_file: non_constant_identifier_names
// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/home_layout/cubit/states.dart';
import 'package:gp2023/layout/home_layout/cubit/cubit.dart';
import 'package:gp2023/shared/components/components.dart';
import '../../modules/applicant_home_module/applicantHome.dart';

import '../applicant_layout/applicant_layout.dart';

class WorkableLayout extends StatelessWidget {
  const WorkableLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkableCubit, WorkableStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Welcome!',
            ),
          ),
          body: ConditionalBuilder(
            condition: WorkableCubit.get(context).model != null,
            builder: (context) {
              var model = FirebaseAuth.instance.currentUser.emailVerified;
              //print(model);
              if (model) {}
              return Column(
                children: [
                  if (!model)
                    Column(children: [
                      Container(
                        color: Colors.amber.withOpacity(.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              const Expanded(
                                child: Text(
                                  'please verify your email',
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              defaultTextButton(
                                function: () {
                                  FirebaseAuth.instance.currentUser
                                      .sendEmailVerification()
                                      .then((value) async {
                                    showToast(
                                      text: 'check your mail',
                                      state: ToastStates.SUCCESS,
                                    );
                                    FirebaseAuth.instance.currentUser.reload();
                                    var user =
                                        await FirebaseAuth.instance.currentUser;
                                    if (user.emailVerified) {
                                      // ignore: use_build_context_synchronously
                                      WorkableCubit.get(context)
                                          .updateIsEmailVerified();
                                      // ignore: use_build_context_synchronously
                                      navigateTo(
                                          context, const ApplicantLayout());
                                    }
                                  }).catchError((error) {});
                                },
                                text: 'send',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Center(child: Columns(context)),
                      )
                    ]),
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
      SizedBox(height: 30,),

      defaultButton(
          function: () {
            navigateTo(context, const ApplicantLayout());
          },
          text: "save And Continue",
        background: Color(0xff1B75BC),
        radius: 50,
        width: 300,
      )
    ]);
  }
}
