// import 'dart:convert';

// import 'package:beautycentre/features/post/domain/entities/post.dart';
// import 'package:beautycentre/features/user/domain/entities/user.dart';
// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../core/error/exceptions.dart';
// import '../../../user/data/models/user_model.dart';

// abstract class AuthLocalDataSource {
//   Future<User> getCachedUser();
//   Future<Unit> cacheUser(List<UserModel> userModels);
// }

// const CACHED_POSTS = "CACHED_POSTS";

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   AuthLocalDataSourceImpl({required this.sharedPreferences});
//   @override
//   Future<Unit> cacheUser(UserModel userModels) {
//     List userModelsToJson = userModels
//         .map<Map<String, dynamic>>((userModel) => userModel.toDocument())
//         .toList();
//     sharedPreferences.setString(CACHED_POSTS, json.encode(userModelsToJson));
//     return Future.value(unit);
//   }

//   @override
//   Future<UserModel> getCachedUser() {
//     final jsonString = sharedPreferences.getString(CACHED_POSTS);
//     if (jsonString != null) {
//       final decodeJsonData = json.decode(jsonString);
//       UserModel jsonToUserModels = decodeJsonData
//           .map<UserModel>(
//               (jsonPostModel) => UserModel.fromSnapshot(jsonPostModel))
//           .toList();
//       return Future.value(jsonToUserModels);
//     } else {
//       throw EmptyCacheException();
//     }
//   }
// }
