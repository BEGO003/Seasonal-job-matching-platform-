import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';

class PersonalInformationState {
  final bool isLoading;
  final bool isChanged;
  final PersonalInformationModel data;
  final String? error;

  const PersonalInformationState({
    this.isLoading = false,
    this.isChanged = false,
    this.data = PersonalInformationModel.empty,
    this.error,
  });

  static const initial = PersonalInformationState();

  PersonalInformationState copyWith({
    bool? isLoading,
    bool? isChanged,
    PersonalInformationModel? data,
    String? error,
  }) {
    return PersonalInformationState(
      isLoading: isLoading ?? this.isLoading,
      isChanged: isChanged ?? this.isChanged,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
  
  PersonalInformationState toLoading() {
    return copyWith(isLoading: true, error: null);
  }

  PersonalInformationState toError(String errorMessage) {
    return copyWith(isLoading: false, error: errorMessage);
  }

  PersonalInformationState toSuccess(PersonalInformationModel data) {
    return copyWith(
      isLoading: false,
      isChanged: true,
      data: data,
      error: null,
    );
  }
}