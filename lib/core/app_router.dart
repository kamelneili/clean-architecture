import 'package:beautycentre/features/appointment/presentation/pages/delivery_time_screen.dart';
import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/profile_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
import '../features/post/presentation/pages/product_details_screen.dart';
import '../home/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/splash':
      //   return MaterialPageRoute(
      //     builder: (_) => SplashScreen(),
      //   );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/ProductDetails':
        return MaterialPageRoute(
          builder: (_) => ProductDetails(
            product: settings.arguments as Post,
          ),
        );
      // case '/basket':
      //   return MaterialPageRoute(
      //     builder: (_) => BasketScreen(),
      //   );
      case '/delivery_time':
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryTimeScreen(product: settings.arguments as Post),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      // case '/account':
      //   return MaterialPageRoute(
      //     builder: (_) => AccountScreen(),
      //   );s
      case '/loginScreen':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/SignupScreen':
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );
      // case '/ProfileScreen':
      //   return MaterialPageRoute(
      //     builder: (_) => SignupScreen(),
      //   );
    }
  }
}
