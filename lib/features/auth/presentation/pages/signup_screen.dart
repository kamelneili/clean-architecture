import 'package:beautycentre/core/widgets/custom_buttom.dart';
import 'package:beautycentre/features/auth/data/repositories/services/storage_service.dart';
import 'package:beautycentre/features/auth/presentation/bloc/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';
  StorageRepository storage = StorageRepository();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: 'Signup'),
      // bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _UserInput(
                  labelText: 'Email',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(email: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Full Name',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(fullName: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Country',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(country: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'City',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(city: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Address',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(address: value),
                        );
                  },
                ),
                _UserInput(
                  labelText: 'ZIP Code',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(zipCode: value),
                        );
                  },
                ),
                _PasswordInput(),
                const SizedBox(height: 10),
                //

                //
                // IconButton(
                //   onPressed: () async {
                //     ImagePicker _picker = ImagePicker();
                //     final XFile? _image = await _picker.pickImage(
                //         source: ImageSource.gallery); //gallery
                //     if (_image == null) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(content: Text('No image was selected')));
                //     }
                //     if (_image != null) {
                //       print('uploading...');
                //       await storage.uploadImage(_image);
                //       var imageUrl = await storage.getDownloadUrl(_image.name);
                //       context.read<SignupCubit>().userChanged(
                //             state.user!.copyWith(imageUrl: imageUrl),
                //           );
                //     }
                //   },
                //   icon: Icon(Icons.add_circle, color: Colors.black),
                // ),

                //

                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child:
                      //  (state.user!.imageUrl == null)?
                      //
                      Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () async {
                        ImagePicker _picker = ImagePicker();
                        final XFile? _image = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );

                        if (_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('No image was selected.')));
                        }

                        if (_image != null) {
                          print('Uploading ...');
                          await storage.uploadImage(_image);
                          var imageUrl =
                              await storage.getDownloadUrl(_image.name);
                          print(imageUrl);
                          context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(imageUrl: imageUrl),
                              );
                          //
                          // BlocProvider.of<AuthBloc>(context).add(
                          //   UpdateUserImages(image: _image),
                          // );
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //

                CustomButton(
                  title: "Signup",
                  onTap: () {
                    context.read<SignupCubit>().signUpWithCredentials();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) {
        context.read<SignupCubit>().passwordChanged(password);
      },
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }
}
