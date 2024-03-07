import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loader.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/loader_widget.dart';
import 'bloc/login_bloc.dart';

const List<String> scopes = <String>[
  'email',
  // 'https://www.googleapis.com/auth/contacts.readonly',
  "https://www.googleapis.com/auth/userinfo.profile"
      "https://www.googleapis.com/auth/openid"
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId:
  //     "911383821282-ctr701l2m3bje5582fto4q8obaeg5irv.apps.googleusercontent.com",

  scopes: scopes,
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool googleUserSigningIn = false;
  GoogleSignInAccount? _currenGoogleUser;
  bool _isGoogeUserAuthorized = false;

  final _phoneNumberPutController = TextEditingController();
  PhoneNumber? phoneNumber;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currenGoogleUser = account;
        _isGoogeUserAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        _googleSignIn.disconnect();
      }
      super.initState();
    });
  }

  Future<UserCredential> signInWithGoogle(context) async {
    try {
      setState(() {
        googleUserSigningIn = true;
      });

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // log(credential.idToken.toString());

      BlocProvider.of<LoginBloc>(context).add(
        OnGoogleSignInButtonClickEvent(
          credential: credential,
        ),
      );

      // Get.dialog(
      //   AlertDialog(
      //     title: const Text('Enter your phone number'),
      //     content: CustomPhoneNumberField(
      //       controller: _phoneNumberPutController,
      //       focusNode: focusNode,
      //       onChanged: (phone) {
      //         setState(() {
      //           phoneNumber = phone;
      //         });
      //       },
      //     ),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Get.back();
      //         },
      //         child: const Text('Cancel', style: TextStyle(color: Colors.red)),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           BlocProvider.of<LoginBloc>(context).add(
      //             OnGoogleSignInButtonClickEvent(
      //               credential: credential,
      //               phoneNumber: phoneNumber?.completeNumber ?? '',
      //             ),
      //           );

      //           Get.back();
      //         },
      //         child: const Text('Submit'),
      //       ),
      //     ],
      //   ),
      // );

      // show modal to enter phonember

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e, s) {
      setState(() {
        googleUserSigningIn = false;
      });

      log(e.toString(), stackTrace: s);

      throw e;
    }
  }

// #docregion signInWithFacebook

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomOverlayLoader(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/images/trmlogo.png',
                      //   height: 200,
                      //   width: 200,
                      // ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: _usernameController,
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
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        contentPadding: const EdgeInsets.all(10),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
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
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(
                              OnLoginButtonClickEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        text: 'Login',
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // forgot password

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // add forgot password button
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),

                          // add button to navigate to forgot password page
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/reset_password');
                            },
                            child: const Text('Click here'),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // add forgot password button
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),

                          // add button to navigate to forgot password page
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/registration');
                            },
                            child: const Text('Register here'),
                          ),
                        ],
                      ),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const Text('Don\'t have an account?'),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // CustomButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, '/registration');
                      //   },
                      //   text: 'Register',
                      // ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text('Or  connect with '),

                      const SizedBox(
                        height: 20,
                      ),

                      // add social media login buttons

                      CustomButton(
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async => signInWithGoogle(context),
                          text: "Google"),

                      const SizedBox(
                        height: 20,
                      ),

                      // CustomButton(
                      //     textStyle: const TextStyle(
                      //       color: Colors.white,
                      //     ),
                      //     buttonStyle: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.blue),
                      //     onPressed: () async => signInWithFacebook(),
                      //     text: "Facebook"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading || googleUserSigningIn) {
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
