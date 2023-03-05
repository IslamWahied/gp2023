import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/hr_tab/cubit/states.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class HrTabCubit extends Cubit<HrTabStates> {
  HrTabCubit() : super(HrTabInitialState());

  static HrTabCubit get(context) => BlocProvider.of(context);
}
