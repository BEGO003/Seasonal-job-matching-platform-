import 'package:job_seeker/models/personal_information_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalInformationStateProvider =
    NotifierProvider<PersonalInformationNotifier, PersonalInformationState>(
      PersonalInformationNotifier.new,
    );

class PersonalInformationNotifier extends Notifier<PersonalInformationState> {
  @override
  PersonalInformationState build() {
    return PersonalInformationState.initial;
  }

  void updateName(String vlaue) {
    state = state.copyWith(isLoading: true);
    Future.delayed(Duration(seconds: 5), () {
      state = state.copyWith(data: state.data.copyWith(name: vlaue));
      state = state.copyWith(isLoading: false);
    });
  }

  void updateEmail(String vlaue) {
    state = state.copyWith(data: state.data.copyWith(email: vlaue));
  }

  void updatePhone(String vlaue) {
    state = state.copyWith(data: state.data.copyWith(phone: vlaue));
  }

  void updateCountry(String vlaue) {
    state = state.copyWith(data: state.data.copyWith(country: vlaue));
  }
}
