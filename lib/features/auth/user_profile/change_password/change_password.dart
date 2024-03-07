import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/custom_loader.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/loader_widget.dart';
import 'bloc/change_password_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: CustomOverlayLoader(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please enter your new password',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    controller: _oldpasswordController,
                    hintText: 'Old Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    hintText: 'New Password',
                    controller: _newpasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ChangePasswordBloc>(context).add(
                          OnChangePasswordbuttonEventClick(
                              oldPassword: _oldpasswordController.text,
                              newPassword: _newpasswordController.text));
                    }
                  },
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
          Positioned(
              child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            builder: (context, state) {
              if (state is ChangePasswordLoading) {
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
