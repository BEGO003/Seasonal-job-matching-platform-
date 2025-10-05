import 'package:country_app/logic/cubit/edit_info_cubit/states.dart';
import 'package:country_app/models/personal_information_Model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInfoCubit extends Cubit<EditInfoStates> {
  EditInfoCubit() : super(EditInfoInitailState()) {
    // Initialize with default values
    personalInformationModel = PersonalInformationModel();
  }

  late final PersonalInformationModel personalInformationModel;

  void changeFiledValue(String label, String value) {
    emit(EditInfoLoadingState());
    try {
      switch (label) {
        case 'Name':
          personalInformationModel.name = value;
          break;
        case 'Phone':
          personalInformationModel.phone = value;
          break;
        case 'Email':
          personalInformationModel.email = value;
          break;
        case 'Country':
          personalInformationModel.country = value;
          break;
      }
      emit(EditInfoSuccessState());
    } catch (e) {
      emit(EditInfoErrorState());
    }
  }
}
