import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/custom_loader.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../bloc/reset_password_bloc.dart';
import 'bloc/confirm_reset_password_bloc.dart';

class ConfirmRestPassword extends StatefulWidget {
  const ConfirmRestPassword({super.key});

  @override
  State<ConfirmRestPassword> createState() => _ConfirmRestPasswordState();
}

class _ConfirmRestPasswordState extends State<ConfirmRestPassword> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomOverlayLoader(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                        if (state is ResetPasswordSuccess) {
                          return Text(
                            state.message!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.red),
                          );
                        }

                        return Text('');
                      }),

                      // token field

                      const SizedBox(
                        height: 30,
                      ),

                      CustomTextFormField(
                        controller: _otpController,
                        hintText: 'Enter your OTP Token',
                        contentPadding: const EdgeInsets.all(10),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your token';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Enter your email',
                        contentPadding: const EdgeInsets.all(10),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // old password field

                      CustomTextFormField(
                        controller: _newpasswordController,
                        hintText: 'Enter your new password',
                        contentPadding: const EdgeInsets.all(10),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // new password field

                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm your new password',
                        contentPadding: const EdgeInsets.all(10),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ConfirmResetPasswordBloc>(context)
                                .add(
                              OnConfirmResetPasswordButtonClickEvent(
                                email: _emailController.text,
                                otp: _otpController.text,
                                newPassword: _newpasswordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                              ),
                            );
                          }
                        },
                        child: const Text('Confirm Reset Password'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(child:
              BlocBuilder<ConfirmResetPasswordBloc, ConfirmResetPasswordState>(
            builder: (context, state) {
              if (state is ConfirmResetPasswordLoading) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()));
              }

              return const Text('');
            },
          ))
        ],
      ),
    );
  }
}
