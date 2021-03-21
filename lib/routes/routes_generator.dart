import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:winsoft_auth_test_app/pages/home_page.dart';
import 'package:winsoft_auth_test_app/pages/login_page.dart';
import 'package:winsoft_auth_test_app/pages/sign_up_page.dart';
import 'package:winsoft_auth_test_app/routes/routes.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case RoutesNames.home:
        return MaterialPageRoute(builder: (_) => HomePage(
          args
        ));
      case RoutesNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutesNames.sign_up:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
      );
    },);
  }
}