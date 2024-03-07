import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/user_regirationn_model.dart';
import '../../models/user_reg_error_model.dart';
import '../../repository.dart';
import 'package:get/get.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  AuthRepository? authRepository;
  RegistrationBloc({this.authRepository}) : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {});

    on<OnRegisterButtonClickEvent>((event, emit) async {
      emit(RegistrationLoading());

      try {
        final user = await authRepository!.register(
          phonenumber: event.phonenumber,
          username: event.username,
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        Get.snackbar('Success', user.message!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        emit(RegistrationSuccess(user));
        Get.toNamed('/validate_account');
      } catch (e) {
        log('Error: $e');
        log(e.toString());
        if (e is String) {
          final message = e.toString();
          Get.snackbar('Error', 'Error occured',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);

          ValidationErrorModel error =
              ValidationErrorModel.fromJson(jsonDecode(message));

          log('Error: ${error.toJson()}');

          emit(RegistrationValidationError(
              message: e.toString(), validationErrorModel: error));
        }
      }
    });
  }
}
