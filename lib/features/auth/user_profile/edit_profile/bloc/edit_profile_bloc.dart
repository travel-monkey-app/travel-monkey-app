import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  AuthRepository? authRepository;
  EditProfileBloc({this.authRepository}) : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnEditProfileButtonClickEvent>((event, emit) async {
      emit(EditProfileLoading());
      try {
        String? message = await authRepository!.editProfile(
          firstName: event.firstName ?? '',
          lastName: event.lastName ?? '',
          email: event.email ?? "",
          phoneNumber: event.phoneNumber ?? '',
          profilePicPath: event.profilePicPath ?? '',
        );
        Get.snackbar('Success', message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        emit(EditProfileSuccess(message: message));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        emit(EditProfileFailure(errorMessage: e.toString()));
      }
    });
  }
}
