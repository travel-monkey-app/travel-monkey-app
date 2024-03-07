import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/auth/user_profile/bloc/user_profile_bloc.dart';
import '../utils/local_storage.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_will_pop_scope.dart';
import '../widgets/loader_widget.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
  "https://www.googleapis.com/auth/userinfo.profile"
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId

  scopes: scopes,
);

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var isDarkModeEnabled = false;

  // special for google sign in user
  GoogleSignInAccount? _currenGoogleUser;
  bool _isGoogeUserAuthorized = false; // has granted permissions?
  var islogingOut = false;

  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(OnUserProfilePageOpenEvent());
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
      if (isAuthorized) {}
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomwillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileSuccess) {
                    return state.userProfilemodel?.userProfilePic != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                state.userProfilemodel?.userProfilePic ?? ''),
                          )
                        : const CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpeg'),
                          );
                  } else {
                    return CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(_currenGoogleUser?.photoUrl ?? ''),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: CustomOverlayLoader(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/logo.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Text(
                      '',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    onTap: () {},
                    trailing: Switch(
                      value: isDarkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          isDarkModeEnabled = value;
                          if (isDarkModeEnabled) {
                            // SecureLocalStorage.saveValue('theme', 'dark');
                            Get.changeThemeMode(ThemeMode.dark);
                          } else {
                            // SecureLocalStorage.saveValue('theme', 'light');
                            Get.changeThemeMode(ThemeMode.light);
                          }
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('My Profile'),
                    onTap: () {
                      Get.offAndToNamed('/user_profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                    onTap: () async {
                      setState(() {
                        islogingOut = true;
                      });

                      if (_isGoogeUserAuthorized) {
                        await _googleSignIn.disconnect();
                      }
                      Get.offAllNamed('/login');
                      await SecureLocalStorage.deleteValue('access_token');
                      await SecureLocalStorage.deleteValue('refresh_token');
                    },
                  ),
                ],
              ),
              Positioned(child: islogingOut ? LoaderWidget() : Container())
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
