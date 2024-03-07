import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loader.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/loader_widget.dart';
import 'bloc/reset_password_bloc.dart';

class ResetPassWord extends StatefulWidget {
  const ResetPassWord({super.key});

  @override
  State<ResetPassWord> createState() => _ResetPassWordState();
}

class _ResetPassWordState extends State<ResetPassWord> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
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
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your email',
                        controller: _emailController,
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
                      CustomButton(
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        textStyle: const TextStyle(color: Colors.white),
                        onPressed: () {
                          // reset password

                          if (_formKey.currentState!.validate()) {
                            // send request
                            BlocProvider.of<ResetPasswordBloc>(context).add(
                              OnResetPasswordButtonClickEvent(
                                email: _emailController.text,
                              ),
                            );
                          }
                        },
                        text: 'Send Request',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            builder: (context, state) {
              if (state is ResetPasswordLoading) {
                return const LoaderWidget();
              }

              return const Text('');
            },
          ))
        ],
      ),
    );
  }
}
