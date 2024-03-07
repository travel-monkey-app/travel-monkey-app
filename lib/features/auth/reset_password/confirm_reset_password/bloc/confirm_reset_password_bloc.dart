import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../repository.dart';

part 'confirm_reset_password_event.dart';
part 'confirm_reset_password_state.dart';

class ConfirmResetPasswordBloc
    extends Bloc<ConfirmResetPasswordEvent, ConfirmResetPasswordState> {
  AuthRepository? authRepository;

  ConfirmResetPasswordBloc({this.authRepository})
      : super(ConfirmResetPasswordInitial()) {
    on<ConfirmResetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnConfirmResetPasswordButtonClickEvent>((event, emit) async {
      emit(ConfirmResetPasswordLoading());
      try {
        String? message = await authRepository!.confirmResetPassword(
          otp: event.otp!,
          email: event.email!,
          newPassword: event.newPassword!,
          cinfirmPassword: event.confirmPassword!,
        );
        Get.snackbar('Success', message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        emit(ConfirmResetPasswordSuccess(message: message));
        Get.toNamed('/login');
      } catch (e) {
        Get.snackbar('Error', "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        emit(ConfirmResetPasswordFailure(errorMessage: e.toString()));
      }
    });
  }
}
