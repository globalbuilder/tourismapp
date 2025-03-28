import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'core/config/theme/theme_manager.dart';
import 'core/config/routes/app_router.dart';
import 'features/accounts/data/accounts_service.dart';
import 'features/accounts/bloc/auth_bloc.dart';
import 'features/accounts/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _dio = Dio();

  @override
  Widget build(BuildContext context) {
    final accountsService = AccountsService(dio: _dio);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        BlocProvider(create: (_) => AuthBloc(accountsService: accountsService)),
        BlocProvider(create: (_) => ProfileBloc(accountsService: accountsService)),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Tourism App',
            debugShowCheckedModeBanner: false,
            theme: themeManager.currentTheme,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
