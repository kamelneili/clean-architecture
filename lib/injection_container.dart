import 'package:beautycentre/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:beautycentre/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:beautycentre/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:beautycentre/features/appointment/domain/usecases/add_appointment.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/basket/basket_bloc.dart';
import 'package:beautycentre/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:beautycentre/features/auth/domain/repositories/auth_repository.dart';
import 'package:beautycentre/features/auth/domain/usecases/sign_up_auth.dart';
import 'package:beautycentre/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:beautycentre/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:beautycentre/features/auth/presentation/bloc/signup/signup_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/log_in_with_email_and_password.dart';
import 'features/post/data/datasources/post_local_data_source.dart';
import 'features/post/data/datasources/post_remote_data_source.dart';
import 'features/post/data/repositories/post_repository_impl.dart';
import 'features/post/domain/repositories/posts_repository.dart';

import 'features/post/domain/usecases/get_all_posts.dart';

import 'features/post/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => SignupCubit(signUpAuthsUsecase: sl()));
  sl.registerFactory(() => LoginCubit(loginusescase: sl()));
  sl.registerFactory(() => ProfileBloc(getUserUsecase: sl()));
  sl.registerFactory(() => AppointmentBloc(addappointmentUsecase: sl()));
  sl.registerFactory(() => BasketBloc());

// Usecasesr
  sl.registerLazySingleton(() => SignUpAuthsUsecase(sl()));

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));

  sl.registerLazySingleton(() => LogInWithEmailAndPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => AddAppointmentUsecase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource: sl(),
      // localDataSource: sl(),
      networkInfo: sl()));
  // sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
  //     remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(
          remoteDataSource: sl(),
          // localDataSource: sl(),
          networkInfo: sl()));
// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  //
  sl.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(firebaseFirestore: sl(), firebaseAuth: sl()));
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(firebaseAuth: sl()));
//

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  final firebaseFirestore = await FirebaseFirestore;
  sl.registerLazySingleton(() => firebaseFirestore);

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //

  final firebaseAuth = await FirebaseAuth.instance;
  //final userRepositoryImpl =   UserRepositoryImpl();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
