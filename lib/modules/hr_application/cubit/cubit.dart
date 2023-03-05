import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/applicant_Saved_module/cubit/states.dart';
import 'package:gp2023/modules/hr_application/cubit/states.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class HrApplicationCubit extends Cubit<HrApplicationStates> {
  HrApplicationCubit() : super(HrApplicationInitialState());

  static HrApplicationCubit get(context) => BlocProvider.of(context);
}
