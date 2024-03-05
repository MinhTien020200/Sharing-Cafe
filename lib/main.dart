import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/provider/event_provider.dart';
import 'package:sharing_cafe/view/screens/init_screen.dart';
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
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sharing Cafe',
        theme: AppTheme.lightTheme(context),
        initialRoute: InitScreen.routeName,
        routes: routes,
      ),
    );
  }
}
