abstract class ApplicantCreateSkillsStates {}

class ApplicantCreateSkillsInitialState extends ApplicantCreateSkillsStates {}

class ApplicantCreateSkillsSuccessState extends ApplicantCreateSkillsStates {
  final String uId;

  ApplicantCreateSkillsSuccessState(this.uId);
}

class ApplicantCreateSkillsErrorState extends ApplicantCreateSkillsStates {
  final String error;

  ApplicantCreateSkillsErrorState(this.error);
}

class ApplicantCreateSkillsChangeCityState
    extends ApplicantCreateSkillsStates {}

class ApplicantCreateSkillsChangeNationalityState
    extends ApplicantCreateSkillsStates {}
