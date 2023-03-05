abstract class ApplicantCreateExperienceStates {}

class ApplicantCreateExperienceInitialState
    extends ApplicantCreateExperienceStates {}

class ApplicantCreateExperienceSuccessState
    extends ApplicantCreateExperienceStates {
  final String uId;

  ApplicantCreateExperienceSuccessState(this.uId);
}

class ApplicantCreateExperienceErrorState
    extends ApplicantCreateExperienceStates {
  final String error;

  ApplicantCreateExperienceErrorState(this.error);
}

class ApplicantCreateExperienceChangeCityState
    extends ApplicantCreateExperienceStates {}

class ApplicantCreateExperienceChangeNationalityState
    extends ApplicantCreateExperienceStates {}
