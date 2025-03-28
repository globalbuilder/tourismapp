
class ApiEndpoints {
  static const String baseUrl = 'https://tourismserver.pythonanywhere.com/api';

  static const String register = '$baseUrl/accounts/register/';
  static const String login = '$baseUrl/accounts/login/';
  static const String refresh = '$baseUrl/accounts/refresh/';
  static const String logout = '$baseUrl/accounts/logout/';

  static const String user = '$baseUrl/accounts/user/';
  static const String profile = '$baseUrl/accounts/profile/';
  static const String changePassword = '$baseUrl/accounts/change-password/';


  static const String categories = '$baseUrl/attractions/categories/';
  static const String attractions = '$baseUrl/attractions/attractions/';
  static const String feedback = '$baseUrl/attractions/feedback/';
  static const String favorites = '$baseUrl/attractions/favorites/';

  static const String notifications = '$baseUrl/notifications/';
}

/// Additional global constants used in the app.
class AppConstants {
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;

  static const String currencySar = 'SAR';
  static const String currencyUsd = 'USD';

}
