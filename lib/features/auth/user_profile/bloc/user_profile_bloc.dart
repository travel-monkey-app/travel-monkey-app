import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../models/user_profile_models.dart';
import '../../repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  AuthRepository? authRepository;
  UserProfileBloc({this.authRepository}) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnUserProfilePageOpenEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        UserProfilemodel? userProfilemodel =
            await authRepository?.fetchUserProfile();
        emit(UserProfileSuccess(userProfilemodel: userProfilemodel));
      } catch (e) {
        // logout the user if the token is expired
        Get.toNamed('/login');
        emit(UserProfileFailure(errorMessage: e.toString()));
      }
    });
  }
}
