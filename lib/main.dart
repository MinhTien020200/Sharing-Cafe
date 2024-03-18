import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/provider/account_provider.dart';
import 'package:sharing_cafe/provider/blog_provider.dart';
import 'package:sharing_cafe/provider/event_provider.dart';
import 'package:sharing_cafe/provider/home_provider.dart';
import 'package:sharing_cafe/view/screens/init_screen.dart';
import 'package:sharing_cafe/view/screens/sign_in/sign_in_screen.dart';
import 'package:sharing_cafe/view/screens/splash/splash_screen.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sharing Cafe',
        theme: AppTheme.lightTheme(context),
        initialRoute: SignInScreen.routeName,
        routes: routes,
      ),
    );
  }
}
