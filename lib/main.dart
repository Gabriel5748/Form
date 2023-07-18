import 'package:flutter/material.dart';
import 'package:formulario/pages/form_submit.dart';
import 'pages/form_page.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const FormPage(),
        '/submit': (context) => const FormSubmit()
      },
      debugShowCheckedModeBanner: false,
    ));
