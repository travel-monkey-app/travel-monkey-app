import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../../../../shared/utils/local_storage.dart';
import '../../repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository? authRepository;

  LoginBloc({this.authRepository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<OnLoginButtonClickEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final user = await authRepository!.login(
          username: event.username!,
          password: event.password!,
        );

        await SecureLocalStorage.writeValue('access_token', user.access!);
        await SecureLocalStorage.writeValue('refresh_token', user.refresh!);
        await SecureLocalStorage.writeValue(
            'isMyFirstRegistrationOrLogin', 'false');

        Get.snackbar('Success', "Login Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        Get.toNamed('/home');

        emit(LoginSuccess());
      } catch (e) {
        Get.snackbar('Error', "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        emit(LoginFailure(errorMessage: e.toString()));
      }
    });

    on<OnGoogleSignInButtonClickEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final user = await authRepository!.googleSignIn(
          accessToken: event.credential.idToken,
          // phoneNumber: event.phoneNumber,
        );

        await SecureLocalStorage.writeValue('access_token', user.access!);
        await SecureLocalStorage.writeValue('refresh_token', user.refresh!);
        await SecureLocalStorage.writeValue(
            'isMyFirstRegistrationOrLogin', 'false');

        Get.snackbar('Success', "Login Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        Get.toNamed('/home');

        emit(LoginSuccess());
      } catch (e) {
        log('Error: $e');
        Get.snackbar('Error', "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        emit(LoginFailure(errorMessage: e.toString()));
      }
    });
  }
}
