import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'features/auth/login/bloc/login_bloc.dart';
import 'features/auth/login/login.dart';
import 'features/auth/registration/bloc/registration_bloc.dart';
import 'features/auth/repository.dart';
import 'features/auth/reset_password/bloc/reset_password_bloc.dart';
import 'features/auth/reset_password/confirm_reset_password/bloc/confirm_reset_password_bloc.dart';
import 'features/auth/user_profile/bloc/user_profile_bloc.dart';
import 'features/auth/user_profile/change_password/bloc/change_password_bloc.dart';
import 'features/auth/user_profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'features/auth/validate_account/bloc/validate_account_bloc.dart';
import 'firebase_options.dart';
import 'shared/environment/environment.dart';
import 'features/auth/registration/registration.dart';
import 'features/auth/reset_password/confirm_reset_password/confirm_reset_password.dart';
import 'features/auth/reset_password/reset_password.dart';
import 'features/auth/user_profile/change_password/change_password.dart';
import 'features/auth/user_profile/user_profile.dart';
import 'features/auth/validate_account/validate_account.dart';
import 'shared/pages/home_page.dart';
import 'shared/pages/onboarding_page.dart';
import 'shared/utils/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await SecureLocalStorage.readValue('access_token') ?? "";

// ...

  await Firebase.initializeApp(
    name: 'Travel Monkey',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(token: token));
}

class MyApp extends StatefulWidget {
  final String? token;

  const MyApp({super.key, required this.token});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isDarkModeEnabled = false;
  bool isMyFirstRegistrationOrLogin = true;

  @override
  void initState() {
    super.initState();
    SecureLocalStorage.readValue('isMyFirstRegistrationOrLogin').then((value) {
      log('isMyFirstRegistrationOrLogin: $value');
      if (value != null) {
        setState(() {
          // isMyFirstRegistrationOrLogin = value.toLowerCase() == 'true';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            environment: Environment.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ValidateAccountBloc>(
            create: (context) => ValidateAccountBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ResetPasswordBloc>(
            create: (context) => ResetPasswordBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ConfirmResetPasswordBloc>(
            create: (context) => ConfirmResetPasswordBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => UserProfileBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<EditProfileBloc>(
            create: (context) => EditProfileBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (context, child) {
              return GetMaterialApp(
                supportedLocales: const <Locale>[
                  Locale('en', ''),
                  Locale('ar', ''),
                ],
                routes: {
                  '/login': (context) => const LoginPage(),
                  '/home': (context) => const Homepage(title: 'Travel Monkey'),
                  '/registration': (context) => const Registration(),
                  '/validate_account': (p0) => const ValidateAccount(),
                  '/reset_password': (context) => const ResetPassWord(),
                  '/confirm_reset_password': (context) =>
                      const ConfirmRestPassword(),
                  '/user_profile': (context) => const UserProfile(),
                  '/change_password': (context) => const ChangePasswordPage(),
                },
                debugShowCheckedModeBanner: false,
                home: widget.token != ""
                    ? const Homepage(title: 'Travel Monkey')
                    : isMyFirstRegistrationOrLogin
                        ? const LandingPage()
                        : LoginPage(),
                theme: ThemeData(
                  primaryColor: Color.fromARGB(255, 121, 184, 236),
                  colorScheme: const ColorScheme.light(
                    primary: Colors.blue,
                    secondary: Colors.blue,
                    onPrimary: Colors.white,
                    onSecondary: Colors.white,
                  ),
                  useMaterial3: true,
                ),
                themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
              );
            }),
      ),
    );
  }
}
