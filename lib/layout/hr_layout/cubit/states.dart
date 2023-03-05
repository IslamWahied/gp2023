abstract class HrStates {}

class HrInitialState extends HrStates {}

class HrUserStringState extends HrStates {}

class HrChangeBottomNavBarState extends HrStates {}

class AppChangeBottomSheetState extends HrStates {}

class HrSaveSuccessState extends HrStates {}

class HrGetUserErrorState extends HrStates {
  final String error;

  HrGetUserErrorState(this.error);
}
