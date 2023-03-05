abstract class ApplicantPrimativeDataStates {}

class ApplicantPrimativeDataInitialState extends ApplicantPrimativeDataStates {}

class ApplicantPrimativeDataSuccessState extends ApplicantPrimativeDataStates {
  final String uId;

  ApplicantPrimativeDataSuccessState(this.uId);
}

class ApplicantPrimativeDataErrorState extends ApplicantPrimativeDataStates {
  final String error;

  ApplicantPrimativeDataErrorState(this.error);
}

class ApplicantPrimativeDataChangeCityState
    extends ApplicantPrimativeDataStates {}


class ApplicantPrimativeDataChangeCountryState
    extends ApplicantPrimativeDataStates {}


class ApplicantPrimativeDataChangeEducationLevelState
    extends ApplicantPrimativeDataStates {}



class ApplicantPrimativeDataChangeNationalityState
    extends ApplicantPrimativeDataStates {}

class ApplicantPrimativeDataChangeJopTitleState extends ApplicantPrimativeDataStates {}

class ApplicantPrimativeDataChangeGradeState extends ApplicantPrimativeDataStates {}

