abstract class ApplicantCreateEducationStates {}

class ApplicantCreateEducationInitialState
    extends ApplicantCreateEducationStates {}

class ApplicantCreateEducationSuccessState
    extends ApplicantCreateEducationStates {
  final String uId;

  ApplicantCreateEducationSuccessState(this.uId);
}

class ApplicantCreateEducationErrorState
    extends ApplicantCreateEducationStates {
  final String error;

  ApplicantCreateEducationErrorState(this.error);
}

class ApplicantCreateEducationChangeCityState
    extends ApplicantCreateEducationStates {}

class ApplicantCreateEducationChangeNationalityState
    extends ApplicantCreateEducationStates {}
