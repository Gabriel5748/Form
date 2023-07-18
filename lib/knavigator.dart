import 'package:flutter/material.dart';

import 'main.dart';

class KNavigator<T> {
  late final NavigatorState _nav;
  final Object? arguments;
  KNavigator({this.arguments}) {
    if (kGlobalKeyNavigator.currentState != null) {
      _nav = kGlobalKeyNavigator.currentState!;
    } else {
      throw Exception('Navigator needs state!');
    }
  }

  void pop([T? value]) {
    _nav.pop(T);
  }

  Future<T?> pushNamed(Kpages page) {
    return _nav.pushNamed(page.route, arguments: arguments);
  }

  Future<T?> pushReplacementNamed(Kpages page) {
    return _nav.pushReplacementNamed(page.route, arguments: arguments);
  }

  Future<T?> popAndPushNamed(Kpages page) {
    return _nav.popAndPushNamed(page.route, arguments: arguments);
  }

  Future<T?> removeAllAndPush(Kpages page) {
    return _nav.pushNamedAndRemoveUntil(
        page.route, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
