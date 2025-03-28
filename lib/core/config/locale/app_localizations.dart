import 'package:easy_localization/easy_localization.dart';

/// Helper methods for easy_localization usage.
class AppLocalizations {

  static String translate(String key, {List<String>? args, Map<String, String>? namedArgs}) {
    return tr(key, args: args, namedArgs: namedArgs);
  }
}
