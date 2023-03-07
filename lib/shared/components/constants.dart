// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int selectedService = 0;
int selectedCategory = 0;
bool isEnglish = true;
String uId;

User userConst;
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}


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
List<String> jopTitles = ["front end web Developer", "Business Systems Analyst", "Azure Synape Microsoft Arthitect/Engineer", "Driver", "receptionist" , "Web Developer", "UI/UX designer", "Permanent Part-Time Sales Assistant", "Integration", "IT Application Integration Technology Technical Manager", "medical senior officer", "full stack intern", "Quayside Superintendent", "Sales Assistant" , "Embedded Software Engineer", "Finance Assistance", "patient safety specialist", "Head of Pre School in London UK" , "Customer Service Consultant", "Sales Consultant at Liberty", "Core-java-tutor", "Vessel Manager x 2", "college management system", "accountant", "Internal Sales", "Client Services Store Co-ordinator", "medical representative" , "social media moderator", "Group Marketing Manager", "SaaS AI invoicing & estimate platform - Contractors", "Recruitment Specialist"];
List<String> jopType = ["Full-Time",'Remote',"Part-Time","Contract"];