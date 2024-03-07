import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loader.dart';
import '../../../shared/widgets/custom_phone_field.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/loader_widget.dart';
import '../models/user_reg_error_model.dart';
import 'bloc/registration_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberPutController = TextEditingController();
  PhoneNumber? phoneNumber;
  FocusNode focusNode = FocusNode();

  ValidationErrorModel? errorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomOverlayLoader(
      children: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationValidationError) {
              setState(() {
                errorModel = state.validationErrorModel;
              });
              _formKey.currentState!.validate();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Registration',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'Please fill the form to register.',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: _usernameController,
                        lableText: 'Username',
                        hintText: 'Enter username',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (errorModel != null &&
                              errorModel!.message!.username != null) {
                            for (var error in errorModel!.message!.username!) {
                              return error;
                            }
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        lableText: 'Email',
                        hintText: 'Enter email',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (errorModel != null &&
                              errorModel!.message!.email != null) {
                            for (var error in errorModel!.message!.email!) {
                              return error;
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomPhoneNumberField(
                        controller: _phoneNumberPutController,
                        focusNode: focusNode,
                        onChanged: (phone) {
                          setState(() {
                            phoneNumber = phone;
                          });
                        },
                      ),
                      errorModel?.message?.phonenumber != null &&
                              errorModel!.message!.phonenumber!.isNotEmpty
                          ? Row(
                              children: [
                                Text(
                                  errorModel?.message?.phonenumber?[0],
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextFormField(
                        controller: _firstNameController,
                        lableText: 'First Name',
                        hintText: 'Enter first name',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: _lastNameController,
                        lableText: 'Last Name',
                        hintText: 'Enter last name',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        lableText: 'Password',
                        hintText: 'Enter password',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (errorModel != null &&
                              errorModel!.message!.password != null) {
                            for (var error in errorModel!.message!.password!) {
                              return error;
                            }
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        lableText: 'Confirm Password',
                        hintText: 'Enter confirm password',
                        contentPadding: const EdgeInsets.all(10),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter confirm password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            String username = _usernameController.text;
                            String email = _emailController.text;
                            String firstName = _firstNameController.text;
                            String lastName = _lastNameController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            errorModel = null;

                            BlocProvider.of<RegistrationBloc>(context).add(
                              OnRegisterButtonClickEvent(
                                phonenumber: phoneNumber!.completeNumber,
                                username: username,
                                email: email,
                                firstName: firstName,
                                lastName: lastName,
                                password: password,
                                confirmPassword: confirmPassword,
                              ),
                            );
                          }
                          errorModel = null;
                        },
                        text: 'Submit',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text("Already have an account?"),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            if (state is RegistrationLoading) {
              return const LoaderWidget();
            }
            return const Text('');
          },
        ))
      ],
    ));
  }
}
