import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulario/pages/form_submit.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _baseUrl = 'https://formulario-41030-default-rtdb.firebaseio.com/';
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final adressController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> submitForm() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    } else {
      await http.post(
        Uri.parse('$_baseUrl/dados.json'),
        body: jsonEncode(
          {
            "Name": nameController.text,
            "CPF": cpfController.text,
            "Adress": adressController.text,
            "E-mail": emailController.text,
          },
        ),
      );

      await precacheImage(
          NetworkImage('lib/assets/images/natureza.jpg'), context);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FormSubmit(),
          ));
    }

    formKey.currentState?.save();
    print(formData.values);
  }

  void clearForm() {
    nameController.clear();
    cpfController.clear();
    adressController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(183, 218, 247, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 50,
            ),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Card(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "CADASTRE-SE GRATUITAMENTE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Obrigado por se cadastrar!!!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: const ListTile(
                        title: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text.rich(TextSpan(
                                      text: "Faça login no Google ",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 93, 168, 230)),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  label: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text.rich(TextSpan(
                                        text: "Coloque seu nome abaixo: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15))
                                        ]))
                                  ],
                                ),
                              )),
                              controller: nameController,
                              onSaved: (name) => formData["Nome"] = name ?? ' ',
                              validator: (_name) {
                                final name = _name ?? ' ';
                                if (name.trim().isEmpty) {
                                  return "É necessário preencher esse campo";
                                }

                                if (name.contains(RegExp('[0-9]'))) {
                                  return "Informe um nome válido";
                                } else {
                                  if (name.trim().length <= 3) {
                                    return "O nome deve conter mais de 3 letras";
                                  }
                                }
                                return null;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  label: Row(
                                children: [
                                  Text.rich(TextSpan(
                                      text: "Coloque seu CPF abaixo: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ))
                                      ]))
                                ],
                              )),
                              controller: cpfController,
                              onSaved: (cpf) =>
                                  formData["CPF"] = int.parse(cpf ?? '0'),
                              validator: (_cpf) {
                                final cpf = _cpf ?? ' ';
                                final numValue = num.tryParse(cpf);

                                if (cpf.isEmpty) {
                                  return "É necessário preencher esse campo";
                                }

                                if (cpf.length < 11 || cpf.length > 11) {
                                  return "Informe um CPF válido";
                                }

                                if (numValue == null || cpf.contains('.')) {
                                  return "Informe um CPF válido";
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  label: Row(
                                children: [
                                  Text.rich(TextSpan(
                                      text: "Coloque seu Endereço abaixo: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ))
                                      ]))
                                ],
                              )),
                              controller: adressController,
                              onSaved: (endereco) =>
                                  formData["endereço"] = endereco ?? ' ',
                              validator: (_endereco) {
                                final endereco = _endereco ?? ' ';

                                if (endereco.trim().isEmpty) {
                                  return "É necessário preencher esse campo";
                                }

                                if (endereco.trim().contains(
                                    RegExp(r"[!#$%&'*+-/=?^_`{|}~]"))) {
                                  return "Informe um endereço válido";
                                } else {
                                  if (endereco.trim().length <= 5) {
                                    return "O endereço deve conter mais de 5 letras";
                                  }
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  label: Row(
                                children: [
                                  Text.rich(TextSpan(
                                      text: "Coloque seu E-mail abaixo: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ))
                                      ]))
                                ],
                              )),
                              controller: emailController,
                              onSaved: (email) =>
                                  formData["email"] = email ?? ' ',
                              validator: (_email) {
                                final email = _email ?? ' ';
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email);

                                if (email.trim().isEmpty) {
                                  return "É necessário preencher esse campo";
                                }

                                if (!email.contains(".com") &&
                                    !emailValid) {
                                  return "Informe um email válido";
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: submitForm,
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
                            child: Text("Limpar formulário",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 36, 146, 248))))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
