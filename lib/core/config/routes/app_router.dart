import 'package:flutter/material.dart';
// Example pages from all features:
import 'package:tourism_frontend/features/app/presentation/pages/splash_page.dart';
import 'package:tourism_frontend/features/app/presentation/pages/home_page.dart';
import 'package:tourism_frontend/features/app/presentation/pages/settings_page.dart';

import 'package:tourism_frontend/features/accounts/presentation/pages/login_page.dart';
import 'package:tourism_frontend/features/accounts/presentation/pages/register_page.dart';
import 'package:tourism_frontend/features/accounts/presentation/pages/profile_page.dart';
import 'package:tourism_frontend/features/accounts/presentation/pages/edit_profile_page.dart';

// import 'package:tourism_frontend/features/notifications/presentation/pages/notifications_page.dart';
// import 'package:tourism_frontend/features/notifications/presentation/pages/notification_details_page.dart';

// import 'package:tourism_frontend/features/attractions/presentation/pages/attractions_page.dart';
// import 'package:tourism_frontend/features/attractions/presentation/pages/attraction_details_page.dart';
// import 'package:tourism_frontend/features/attractions/presentation/pages/category_list_page.dart';
// import 'package:tourism_frontend/features/attractions/presentation/pages/category_attractions_page.dart';

// import 'package:tourism_frontend/features/favorites/presentation/pages/favorites_page.dart';
// import 'package:tourism_frontend/features/feedback/presentation/pages/feedback_page.dart';

// import 'package:tourism_frontend/features/map/presentation/pages/map_screen.dart';
// import 'package:tourism_frontend/features/currency/presentation/pages/currency_convert_page.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';

  static const String profileRoute = '/profile';
  static const String editProfileRoute = '/edit-profile';

  static const String notificationsRoute = '/notifications';
  static const String notificationDetailsRoute = '/notification-details';

  static const String attractionsRoute = '/attractions';
  static const String attractionDetailsRoute = '/attraction-details';
  static const String categoryListRoute = '/category-list';
  static const String categoryAttractionsRoute = '/category-attractions';

  static const String favoritesRoute = '/favorites';
  static const String feedbackRoute = '/feedback';

  static const String mapRoute = '/map-screen';
  static const String currencyConvertRoute = '/currency-convert';

  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());

      // case notificationsRoute:
      //   return MaterialPageRoute(builder: (_) => const NotificationsPage());
      // case notificationDetailsRoute:
      //   final notifId = settings.arguments as int?;
      //   return MaterialPageRoute(
      //     builder: (_) => NotificationDetailsPage(notificationId: notifId),
      //   );

      // case attractionsRoute:
      //   return MaterialPageRoute(builder: (_) => const AttractionsPage());
      // case attractionDetailsRoute:
      //   final attractionId = settings.arguments as int?;
      //   return MaterialPageRoute(
      //     builder: (_) => AttractionDetailsPage(attractionId: attractionId),
      //   );

      // case categoryListRoute:
      //   return MaterialPageRoute(builder: (_) => const CategoryListPage());
      // case categoryAttractionsRoute:
      //   final categoryId = settings.arguments as int?;
      //   return MaterialPageRoute(
      //     builder: (_) => CategoryAttractionsPage(categoryId: categoryId),
      //   );

      // case favoritesRoute:
      //   return MaterialPageRoute(builder: (_) => const FavoritesPage());
      // case feedbackRoute:
      //   return MaterialPageRoute(builder: (_) => const FeedbackPage());

      // case mapRoute:
      //   return MaterialPageRoute(builder: (_) => const MapScreen());
      // case currencyConvertRoute:
      //   return MaterialPageRoute(builder: (_) => const CurrencyConvertPage());

      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
