import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_Saved_module/cubit/states.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class ApplicantSavedRegisterCubit extends Cubit<ApplicantSavedRegisterStates> {
  ApplicantSavedRegisterCubit() : super(ApplicantSavedHomeInitialState());

  static ApplicantSavedRegisterCubit get(context) => BlocProvider.of(context);
}
