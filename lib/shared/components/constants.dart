// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String uId;

User userConst;


String defaultDropDownListValue = "--Select--";

List<String> citiesList = [
  "--Select--",
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
List<String> countriesList = [
  "--Select--",
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
List<String> jopTitlesList = ["front end web Developer", "Business Systems Analyst", "Azure Synape Microsoft Arthitect/Engineer", "Driver", "receptionist" , "Web Developer", "UI/UX designer", "Permanent Part-Time Sales Assistant", "Integration", "IT Application Integration Technology Technical Manager", "medical senior officer", "full stack intern", "Quayside Superintendent", "Sales Assistant" , "Embedded Software Engineer", "Finance Assistance", "patient safety specialist", "Head of Pre School in London UK" , "Customer Service Consultant", "Sales Consultant at Liberty", "Core-java-tutor", "Vessel Manager x 2", "college management system", "accountant", "Internal Sales", "Client Services Store Co-ordinator", "medical representative" , "social media moderator", "Group Marketing Manager", "SaaS AI invoicing & estimate platform - Contractors", "Recruitment Specialist"];
List<String> gradesList = ["--Select--",'Excellent', 'Very Good', 'Good'];
List<String> nationalityList = [
  "--Select--",
  'Egyptian',
  'American',
  'Canadian',
  'Russian',
  'Australian'
      'Bahamaian',
  'Brazilian',
  'French',
  'Greek'
];
List<String> jopType = ["--Select--","Full-Time", 'Remote', "Part-Time", "Contract"];
List<String> genderList = ["--Select--","Male","Female"];
List<String> uniList = ["--Select--",
  "Cairo University",
  "Mansoura University",
  "Ain Shams University",
  "Alexandria University",
  "Kafrelsheikh University",
  "AAST",
  "Al Azhar University",
  "MTI",
  "MSA",
  "Modern Academy"
];
List<String> educationLevelsList = ["--Select--","Masters", "phd",'bachelor s'];
List<String> facultiesList = ["--Select--","computer science", "Engineering",'bussiness','Medicine',' Law','Art',' Mass Communication'];
List<String> positionsList = ["--Select--","Team leader",
  "Manager",
  'Administrative assistant',
  'Business analyst',
  'Sales representative',
  'Marketing manager',
  'Product manager',
  'Software engineer',
  'Project Manager',
  'Marketing Coordinator',
  'Supervisor',
  'Quality Control',
  'Accounting Staff',
];

