// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/layout/home_layout/home_screen.dart';
import 'package:gp2023/modules/register_module/cubit/cubit.dart';
import 'package:gp2023/modules/register_module/cubit/states.dart';
import 'package:gp2023/shared/components/components.dart';

// ignore: must_be_immutable
class WorkableRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  static const genderList = <String>[
    'Male',
    'Female',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = genderList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  WorkableRegisterScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WorkableRegisterCubit(),
      child: BlocConsumer<WorkableRegisterCubit, WorkableRegisterStates>(
        listener: (context, state) {
          if (state is WorkableCreateUserSuccessState) {
            navigateAndFinish(
              context,
              const WorkableLayout(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        logoIcon(),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyLarge.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            var emailregex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                            if (!emailregex.hasMatch(value)) {
                              return 'please enter a valid email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: WorkableRegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword:
                              WorkableRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            WorkableRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },

                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ListTile(
                          title: const Text('What is your gender? '),
                          trailing: DropdownButton<String>(
                            // Must be one of items.value.
                            value: WorkableRegisterCubit.get(context).isMale
                                ? 'Male'
                                : 'Female',
                            onChanged: (String newValue) {
                              if (newValue != null) {
                                WorkableRegisterCubit.get(context)
                                    .changeUserGenderIsMale(newValue);
                              }
                            },
                            items: _dropDownMenuItems,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! WorkableRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                WorkableRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    isApplicant: true);
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
