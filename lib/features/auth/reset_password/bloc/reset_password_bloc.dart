import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  AuthRepository? authRepository;

  ResetPasswordBloc({this.authRepository}) : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnResetPasswordButtonClickEvent>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        String? message = await authRepository!.resetPassword(
          email: event.email!,
        );
        Get.snackbar('Success', message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        emit(ResetPasswordSuccess(message: message));
        Get.toNamed('/confirm_reset_password');
      } catch (e) {
        Get.snackbar('Error', "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        emit(ResetPasswordFailure(errorMessage: e.toString()));
      }
    });
  }
}
