// @dart=2.9
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class JobModel {
  final String ID;
  final String company_ID;
  final String jobTitle;
  final String jobDescription;
  final String JobType;
  final String JobIcon;
  final double salary;
  final String role;
  final DateTime startDate;
  final DateTime endDate;

  // constructor
  JobModel({
    @required this.ID,
    @required this.company_ID,
    @required this.JobIcon,
    @required this.jobTitle,
    @required this.jobDescription,
    @required this.JobType,
    @required this.role,
    @required this.salary,
    @required this.startDate,
    @required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    'ID':ID,
    'JobIcon':JobIcon??icons[new Random().nextInt(5)],
    'Company_ID': company_ID,
    'JobTitle': jobTitle,
    'JobDescription': jobDescription,
    'JobType': JobType,
    'Salary': salary,
    'Role': role,
    'StartDate': startDate,
    'EndDate': endDate,
  };

  // function to convert Json to Job object.
  static JobModel fromJson(Map<String, dynamic> json) => JobModel(
    ID: json['ID'],
    JobIcon: json['JobIcon']??icons[new Random().nextInt(5)],
    company_ID: json['Company_ID'],
    jobTitle: json['JobTitle'],
    jobDescription: json['JobDescription'],
    JobType: json['JobType'],
    salary: json['Salary'].toDouble(),
    role: json['Role'],
    startDate: (json['StartDate']as Timestamp).toDate(),
    endDate: (json['EndDate']as Timestamp).toDate(),

  );
}

var icons = [
  'assets/IconsImage/certicraft.png',
  'assets/IconsImage/beanworks.jpeg',
  'assets/IconsImage/mailchimp.jpeg',
  'assets/IconsImage/mozila.png',
  'assets/IconsImage/reddit.jpeg',
];