import 'package:beautycentre/core/config/constants.dart';
import 'package:beautycentre/core/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../bloc/profile/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: RouteSettings(name: routeName),
  //     builder: (context) => BlocProvider<ProfileBloc>(
  //       create: (context) => ProfileBloc(
  //         authBloc: BlocProvider.of<AuthBloc>(context),
  //         userRepository: context.read<UserRepository>(),
  //       )..add(
  //           LoadProfile(context.read<AuthBloc>().state.authUser),
  //         ),
  //       child: ProfileScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(title: 'Profile'),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          //  LocaleKeys.myprofil.tr(),
          'profile',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black),
        ),
      ),
      // bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // print(BlocProvider.of<AuthBloc>(context).state);

          if (state is ProfileLoading) {
            return Center(
                // child: CircularProgressIndicator(color: Colors.black),
                );
          }
          if (state is ProfileLoaded) {
            print('state is profileloaded');

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        height: 130,
                        width: 160,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(state.user.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                          int? expSize;
                          int? dowSize;
                          expSize = loadingProgress?.expectedTotalBytes;
                          dowSize = loadingProgress?.cumulativeBytesLoaded;
                          if (expSize != null && dowSize != null) {
                            var loadPerc = (dowSize / expSize).toDouble() * 100;
                            var loadPercString = loadPerc.toStringAsFixed(2);
                            return Column(
                              children: [
                                Text(
                                  '$loadPercString%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LinearProgressIndicator(value: loadPerc),
                              ],
                            );
                          } else {
                            return child;
                          }
                        })),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    LocaleKeys.personalInformation.tr(),
                    style: kEncodeSansSemiBold.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    title: LocaleKeys.email.tr(),
                    initialValue: state.user.email,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(email: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: LocaleKeys.name.tr(),
                    initialValue: state.user.fullName,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(fullName: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: LocaleKeys.adress.tr(),
                    initialValue: state.user.address,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(address: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: LocaleKeys.city.tr(),
                    initialValue: state.user.city,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(city: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: LocaleKeys.country.tr(),
                    initialValue: state.user.country,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(country: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: LocaleKeys.zip.tr(),
                    initialValue: state.user.zipCode,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateProfile(
                              user: state.user.copyWith(zipCode: value),
                            ),
                          );
                    },
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: CustomButton(
                      title: 'Back to home',
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            print(state.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'You are not logged in!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  title: 'Login',
                  onTap: () {
                    Navigator.pushNamed(context, '/loginScreen');
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                CustomButton(
                  title: "Signup",
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                    //  context.read<AuthRepository>().signOut();
                  },
                ),
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
