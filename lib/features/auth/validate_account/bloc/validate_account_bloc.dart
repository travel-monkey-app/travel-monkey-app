import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../../../../shared/utils/local_storage.dart';
import '../../repository.dart';
part 'validate_account_event.dart';
part 'validate_account_state.dart';

class ValidateAccountBloc
    extends Bloc<ValidateAccountEvent, ValidateAccountState> {
  AuthRepository? authRepository;

  ValidateAccountBloc({this.authRepository}) : super(ValidateAccountInitial()) {
    on<ValidateAccountEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnValidateAccountButtonClickEvent>((event, emit) async {
      emit(ValidateAccountLoading());
      try {
        String? message = await authRepository!.validateAccount(
          otp: event.otp!,
          email: event.email!,
        );

        Get.snackbar('Success', message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        emit(ValidateAccountSuccess(message: message));
        await SecureLocalStorage.writeValue(
            'isMyFirstRegistrationOrLogin', false.toString());

        Get.toNamed('/login');
      } catch (e) {
        Get.snackbar('Error', "Error occured",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        emit(ValidateAccountFailure(errormessage: e.toString()));
      }
    });

    on<OnResendOtpButtonClickEvent>((event, emit) async {
      emit(ResendOtpLoading());
      try {
        String? message = await authRepository!.resendValidateAccountOtp(
          email: event.email!,
        );

        Get.snackbar('Success', message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        emit(ResendOtpSuccess(message: message));
      } catch (e) {
        Get.snackbar('Error', "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        emit(ResendOtpFailure(errormessage: e.toString()));
      }
    });
  }
}
