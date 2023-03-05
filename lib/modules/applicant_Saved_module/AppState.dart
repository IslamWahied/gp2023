// @dart=2.9
import 'package:flutter/material.dart';

class ApplicantSavedHome extends StatelessWidget {
  const ApplicantSavedHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Saved Jobs'), CircularProgressIndicator()]));
  }
}
