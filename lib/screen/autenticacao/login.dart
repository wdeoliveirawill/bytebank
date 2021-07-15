import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/screen/autenticacao/signin.dart';
import 'package:bytebank/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: SingleChildScrollView(
            child: buildForm(context),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/bytebank_logo.png",
              width: 200,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 460,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Faça seu login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "CPF",
                      ),
                      maxLength: 14,
                      keyboardType: TextInputType.number,
                      controller: _cpfController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      validator: (value) =>
                          Validator.cpf(value) ? "CPF inválido" : null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Senha",
                      ),
                      maxLength: 15,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a Senha";
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                                (route) => false);
                          } else {
                            showAlert(
                                context: context,
                                title: "Atenção!!",
                                content: "CPF ou Senha incorretos");
                          }
                        },
                        child: Text(
                          "CONTINUAR",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Esqueci minha senha",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Criar uma conta",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  bool _validateFakeLogin() {
    return _cpfController.text == "052.431.339.30" &&
        _passwordController.text == "123";
  }
}
