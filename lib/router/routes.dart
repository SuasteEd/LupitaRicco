//Rutas nombradas

import 'package:flutter/material.dart';
import 'package:lupita_ricco/router/routes_barrel.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomePage(),
  };
}