import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository? authRepository;

  ChangePasswordBloc({this.authRepository}) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnChangePasswordbuttonEventClick>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        String? message = await authRepository!.changePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        Get.snackbar('Success', message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        emit(ChangePasswordSuccess(message: message));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        emit(ChangePasswordFailure(message: e.toString()));
      }
    });
  }
}
