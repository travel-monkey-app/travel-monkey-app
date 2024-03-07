import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/custom_loader.dart';
import '../../../shared/widgets/loader_widget.dart';
import 'bloc/user_profile_bloc.dart';
import 'edit_profile/edit_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? image = '';

  @override
  void initState() {
    super.initState();

    var state = BlocProvider.of<UserProfileBloc>(context).state;
    if (state is UserProfileSuccess) {
      image = state.userProfilemodel!.userProfilePic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomOverlayLoader(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          if (state.userProfilemodel!.userProfilePic != null) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                // radius: 50,
                                maxRadius: 50,
                                minRadius: 30,
                                // backgroundImage:
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.userProfilemodel!.userProfilePic!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  'assets/images/avatar.jpeg',
                                ));
                          }
                        }
                        return const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpeg'));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                          if (state is UserProfileSuccess) {
                            return IconButton(
                                onPressed: () {
                                  Get.to(() => EditProfile(
                                        userProfilemodel:
                                            state.userProfilemodel,
                                      ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ));
                          } else {
                            return const CircularProgressIndicator(
                              strokeWidth: 1,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('User name'),
                    onTap: () {},
                    trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          return Text(state.userProfilemodel!.user!.username
                              .toString());
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 1,
                          );
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          return Text(
                              state.userProfilemodel!.user!.email.toString());
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 1,
                          );
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('First Name'),
                    trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          return Text(state.userProfilemodel!.user!.firstName
                              .toString());
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 1,
                          );
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Last Name'),
                    trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          return Text(state.userProfilemodel!.user!.lastName
                              .toString());
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 1,
                          );
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone Number'),
                    trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileSuccess) {
                          return Text(state.userProfilemodel!.phone ?? '');
                        } else {
                          return const CircularProgressIndicator(
                            strokeWidth: 1,
                          );
                        }
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      trailing: BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                          if (state is UserProfileSuccess) {
                            return IconButton(
                                onPressed: () {
                                  Get.toNamed('/change_password');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ));
                          } else {
                            return const CircularProgressIndicator(
                              strokeWidth: 1,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoading) {
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
