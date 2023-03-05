// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp2023/modules/login_module/login.dart';
import 'package:gp2023/shared/network/local/cache_helper.dart';
import '../../modules/applicant_create_CV/applicantPrimativeData.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';

Widget logoIcon() => const Center(
      child: Image(
        image: AssetImage('assets/images/workable.png'),
        height: 200,
        width: 200,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
  int maxLine = 1,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      maxLines: maxLine,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color:Color(0xff1B75BC),


        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                    color:Color(0xff1B75BC),

                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget initiateHrDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        new UserAccountsDrawerHeader(
          onDetailsPressed: () {},
          accountName: Text(CacheHelper.getData(key: 'name')),
          accountEmail: Text(CacheHelper.getData(key: 'email')),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png',
              ),

              // child: Icon(
              //   Icons.person,
              //   size: 60,
              //   color: Colors.white,
              // ),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xff1B75BC),
          ),
        ),
        ListTile(
            leading: Icon(Icons.content_paste),
            title: Text('Create CV'),
            onTap: () {
              navigateTo(context, ApplicantPrimativeDataHome());
            }),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            CacheHelper.removeData(key: 'name');
            CacheHelper.removeData(key: 'email');
            CacheHelper.removeData(key: 'uId');
            navigateTo(context, WorkableLoginScreen());
          },
        ),
      ],
    ),
  );
}

Widget initiateDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        new UserAccountsDrawerHeader(
          onDetailsPressed: () {},
          accountName: Text(CacheHelper.getData(key: 'name')),
          accountEmail: Text(CacheHelper.getData(key: 'email')),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png'),

              // child: Icon(
              //   Icons.person,
              //   size: 60,
              //   color: Colors.white,
              // ),
            ),
          ),
          decoration: BoxDecoration(
            color: defaultColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            CacheHelper.removeData(key: 'name');
            CacheHelper.removeData(key: 'email');
            CacheHelper.removeData(key: 'uId');
            CacheHelper.removeData(key: 'companyName');
            CacheHelper.removeData(key: 'isApplicant');
            navigateTo(context, WorkableLoginScreen());
          },
        ),
      ],
    ),
  );
}
