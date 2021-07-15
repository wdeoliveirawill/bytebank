import 'package:bytebank/models/customer.dart';
import 'package:bytebank/screen/autenticacao/login.dart';
import 'package:bytebank/screen/dashboard/saldo.dart';
import 'package:bytebank/screen/deposito/formulario.dart';
import 'package:bytebank/screen/transferencia/formulario.dart';
import 'package:bytebank/screen/transferencia/ultimas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bytebank"),
      ),
      body: ListView(
        children: [
          Consumer<Customer>(
            builder: (context, value, child) {
              String name = "";
              if (value.name != null) {
                name = " ${value.name.split(" ")[0]}";
              }
              return Text(
                "Olá$name, seu saldo de hoje é:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioDeposito(),
                    ),
                  );
                },
                child: Text("Receber depósito"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioTransferencia(),
                    ),
                  );
                },
                child: Text("Nova Transferência"),
              ),
            ],
          ),
          UltimasTransferencias(),
          RaisedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false,
              );
            },
            color: Colors.green,
            child: Text("Sair"),
          )
        ],
      ),
    );
  }
}
