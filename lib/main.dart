import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formulario/pages/splash/splash_page.dart';
import 'package:formulario/pages/submit/submit_page.dart';
import 'pages/form/form_page.dart';

void main() {
  runApp(const ProviderScope(child: AppWidget()));
}

final GlobalKey<NavigatorState> kGlobalKeyNavigator =
    GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kGlobalKeyNavigator,
      initialRoute: Kpages.init.route,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

Map<String, WidgetBuilder> routes = {
  Kpages.init.route: (context) => const FormPage(),
  Kpages.submit.route: (context) => const FormSubmit(),
  Kpages.splash.route: (context) => const SplashPage()
};

extension Router on Kpages {
  String get route => "/$name/";
}

enum Kpages { init, submit, splash }
