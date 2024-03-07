import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loader.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/loader_widget.dart';
import '../registration/bloc/registration_bloc.dart';
import 'bloc/validate_account_bloc.dart';

class ValidateAccount extends StatefulWidget {
  const ValidateAccount({super.key});

  @override
  State<ValidateAccount> createState() => _ValidateAccountState();
}

class _ValidateAccountState extends State<ValidateAccount> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var UserRegistrationState;
  var message;

  @override
  void initState() {
    super.initState();

    UserRegistrationState = BlocProvider.of<RegistrationBloc>(context).state;
    if (UserRegistrationState is RegistrationSuccess) {
      message = UserRegistrationState.userRegirationnModel.message;
      _emailController.text =
          UserRegistrationState.userRegirationnModel.email ?? '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
                      'Account Validation',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '${message}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      lableText: 'Email',
                      hintText: 'Enter email',
                      contentPadding: const EdgeInsets.all(10),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // add otp field

                    CustomTextFormField(
                      controller: _otpController,
                      lableText: 'OTP',
                      hintText: 'Enter OTP',
                      contentPadding: const EdgeInsets.all(10),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // add button to validate account
                    CustomButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ValidateAccountBloc>(context).add(
                            OnValidateAccountButtonClickEvent(
                              email: _emailController.text,
                              otp: _otpController.text,
                            ),
                          );
                        }
                      },
                      text: 'Validate Account',
                    ),

                    Row(
                      children: [
                        const Text('Did not receive an otp?'),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<ValidateAccountBloc>(context)
                                .add(OnResendOtpButtonClickEvent(
                              email: _emailController.text,
                            ));
                          },
                          child: const Text('Resend OTP'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            child: BlocBuilder<ValidateAccountBloc, ValidateAccountState>(
          builder: (context, state) {
            if (state is ValidateAccountLoading || state is ResendOtpLoading) {
              return const LoaderWidget();
            }

            return const Text('');
          },
        ))
      ],
    ));
  }
}
