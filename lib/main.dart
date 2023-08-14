import 'package:beautycentre/core/translations/codegen_loader.g.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/basket/basket_bloc.dart';
import 'package:beautycentre/features/auth/domain/usecases/sign_up_auth.dart';
import 'package:beautycentre/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:beautycentre/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:beautycentre/features/auth/presentation/bloc/signup/signup_cubit.dart';
import 'package:beautycentre/features/auth/presentation/pages/login_screen.dart';
import 'package:beautycentre/features/auth/presentation/pages/signup_screen.dart';
import 'package:beautycentre/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_router.dart';
import 'core/app_theme.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'features/post/presentation/pages/posts_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  await di.init();
  runApp(EasyLocalization(
      path: 'assets/translations',
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('de'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(
        appRouter: AppRouter(),
      )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<ProfileBloc>()),
          BlocProvider(create: (context) => di.sl<SignupCubit>()),
          BlocProvider(create: (context) => di.sl<LoginCubit>()),
          BlocProvider(create: (_) => di.sl<AppointmentBloc>()),
          BlocProvider(create: (_) => di.sl<BasketBloc>()..add(StartBasket())),
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        ],
        child: MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            onGenerateRoute: appRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
            home: HomeScreen()));
  }
}
