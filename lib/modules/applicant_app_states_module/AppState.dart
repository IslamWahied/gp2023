// @dart=2.9
import 'package:flutter/material.dart';

class ApplicantAppStateHome extends StatelessWidget {
  const ApplicantAppStateHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Text('Application States'),
          CircularProgressIndicator()
        ]));
  }
}
