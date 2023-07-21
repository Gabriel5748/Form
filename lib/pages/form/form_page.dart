// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulario/knavigator.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../main.dart';
import 'components/form_input_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _baseUrl = 'https://formulario-41030-default-rtdb.firebaseio.com/';
  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final adressController = TextEditingController();
  final emailController = TextEditingController();

  void sendForm() {
    KNavigator().pushNamed(Kpages.splash);
    postFormMethod().then((value) {
      precacheImage(
          const NetworkImage('lib/assets/images/natureza.jpg'), context);
      KNavigator().removeAllAndPush(Kpages.submit);
    });
  }

  Future<void> postFormMethod() async {
    await http.post(Uri.parse('$_baseUrl/dados.json'),
        body: jsonEncode(
          {
            "Name": nameController.text,
            "CPF": cpfController.text,
            "Adress": adressController.text,
            "E-mail": emailController.text,
          },
        ));
  }

  void clearForm() {
    nameController.clear();
    cpfController.clear();
    adressController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 218, 247, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultMargin, //numeros magicos pq sim
            horizontal: 50,
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  const Card(
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.all(kDefaultContentPadding),
                        child: Text(
                          "CADASTRE-SE GRATUITAMENTE",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.all(kDefaultContentPadding),
                        child: Text(
                          "Obrigado por se cadastrar!!!",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      title: Padding(
                          padding: EdgeInsets.all(kDefaultContentPadding),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text.rich(TextSpan(
                                    text: "Faça login no Google ",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 93, 168, 230)),
                                    children: [
                                      TextSpan(
                                          text:
                                              "para salvar o que você já preencheu.",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: " Saiba mais",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 93, 168, 230)))
                                          ])
                                    ])),
                              )
                            ],
                          )),
                      subtitle: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "*Obrigatório",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultSepartorHeigth),
                  FormInputField(
                    description: 'Coloque seu nome:',
                    isRequired: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: kDefaultSepartorHeigth),
                  FormInputField(
                    description: 'Coloque seu CPF abaixo:',
                    isRequired: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: kDefaultSepartorHeigth),
                  FormInputField(
                    description: 'Coloque seu Endereço abaixo:',
                    isRequired: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: kDefaultSepartorHeigth),
                  FormInputField(
                    description: 'Coloque seu E-mail abaixo',
                    isRequired: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: kDefaultSepartorHeigth),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: sendForm,
                          child: const Text(
                            "Enviar",
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              clearForm();
                            });
                          },
                          child: const Text("Limpar formulário",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 36, 146, 248))))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// /  validator: (name) {
//               final name = name ?? ' ';
//               if (name.trim().isEmpty) {
//                 return "É necessário preencher esse campo";
//               }

//               if (name.contains(RegExp('[0-9]'))) {
//                 return "Informe um nome válido";
//               } else {
//                 if (name.trim().length <= 3) {
//                   return "O nome deve conter mais de 3 letras";
//                 }
//               }
//               return null;
//             }),
//  final cpf = cpf ?? ' ';
//                               final numValue = num.tryParse(cpf);

//                               if (cpf.isEmpty) {
//                                 return "É necessário preencher esse campo";
//                               }

//                               if (cpf.length < 11 || cpf.length > 11) {
//                                 return "Informe um CPF válido";
//                               }

//                               if (numValue == null || cpf.contains('.')) {
//                                 return "Informe um CPF válido";
//                               }

//                               return null;
    // formData["email"] = email ?? ' ',
    //                         validator: (email) {
    //                           final email = email ?? ' ';
    //                           bool emailValid = RegExp(
    //                                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //                               .hasMatch(email);

    //                           if (email.trim().isEmpty) {
    //                             return "É necessário preencher esse campo";
    //                           }

    //                           if (!email.contains(".com") && !emailValid) {
    //                             return "Informe um email válido";
    //                           }

    //                           return null;