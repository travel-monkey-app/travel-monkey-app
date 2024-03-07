import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/widgets/custom_loader.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/loader_widget.dart';
import '../../models/user_profile_models.dart';
import '../bloc/user_profile_bloc.dart';
import 'bloc/edit_profile_bloc.dart';

class EditProfile extends StatefulWidget {
  final UserProfilemodel? userProfilemodel;
  const EditProfile({super.key, this.userProfilemodel});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _formKey = GlobalKey<FormState>();
  PhoneNumber? phoneNumber;
  FocusNode focusNode = FocusNode();

  File? _image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();

  // var _phoneNumberController = TextEditingController();
  var _phoneNumberPutController = TextEditingController();

  var _emailController = TextEditingController();
  var _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(
      text: widget.userProfilemodel!.user?.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.userProfilemodel!.user?.lastName,
    );

    _phoneNumberPutController = TextEditingController(
      text: widget.userProfilemodel!.phone,
    );

    _emailController = TextEditingController(
      text: widget.userProfilemodel!.user?.email,
    );

    _usernameController = TextEditingController(
      text: widget.userProfilemodel!.user?.username,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          BlocProvider.of<UserProfileBloc>(context)
              .add(OnUserProfilePageOpenEvent());
        } else if (state is EditProfileFailure) {}
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //     BlocProvider.of<UserProfileBloc>(context)
          //         .add(OnUserProfilePageOpenEvent());
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          title: const Text('Edit Profile'),
        ),
        body: CustomOverlayLoader(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _image != null
                                      ? FileImage(_image ?? File(''))
                                          as ImageProvider<Object>
                                      : NetworkImage(
                                          widget.userProfilemodel!
                                                  .userProfilePic ??
                                              '',
                                        )

                                  // : NetworkImage(
                                  //   widget.userProfilemodel!.userProfilePic!,
                                  // ),
                                  ),
                            ),
                            Positioned(
                                top: 80,
                                right: 9,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: showOptions,
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                )),
                          ],
                        ),

                        CustomTextFormField(
                          hintText: 'Username',
                          controller: _usernameController,
                          enabled: false,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        CustomTextFormField(
                          hintText: 'First Name',
                          controller: _firstNameController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'First Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hintText: 'Last Name',
                          controller: _lastNameController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Last Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        CustomTextFormField(
                          hintText: 'Email',
                          enabled: true,
                          controller: _emailController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // CustomPhoneNumberField(
                        //   controller: _phoneNumberPutController,
                        //   focusNode: focusNode,
                        //   onChanged: (phone) {
                        //     setState(() {
                        //       phoneNumber = phone;
                        //     });
                        //   },
                        // ),

                        CustomTextFormField(
                          hintText: 'Phone Number',
                          controller: _phoneNumberPutController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              // checj phoneNumber
                              if (_phoneNumberPutController.text.length < 10) {
                                Get.snackbar(
                                    'Error', 'Phone number is required');
                                return;
                              }

                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<EditProfileBloc>(context).add(
                                  OnEditProfileButtonClickEvent(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    phoneNumber: _phoneNumberPutController.text,
                                    profilePicPath: _image?.path,
                                  ),
                                );
                              } else {
                                Get.snackbar('Error', 'Form is not valid');
                              }
                            },
                            child: const Text('Update Profile'),
                          ),
                        ),

                        // token field
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(child: BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const LoaderWidget();
                }

                return const Text('');
              },
            ))
          ],
        ),
      ),
    );
  }
}
