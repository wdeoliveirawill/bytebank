import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screen/dashboard/saldo.dart';
import 'package:bytebank/screen/deposito/formulario.dart';
import 'package:bytebank/screen/transferencia/formulario.dart';
import 'package:bytebank/screen/transferencia/lista.dart';
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
        ],
      ),
    );
  }
}
