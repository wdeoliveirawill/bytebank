import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Últimas transferências",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final counter = transferencias.transferencias.length < 2
                ? transferencias.transferencias.length
                : 2;
            if (counter == 0) {
              return SemTransferencias();
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: counter,
              itemBuilder: (context, index) {
                return ItemTransferencia(
                    transferencias.ultimasTransferencias[index]);
              },
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListaTransferencias(),
              ),
            );
          },
          child: Text("Ver todas as Transferências"),
        ),
      ],
    );
  }
}

class SemTransferencias extends StatelessWidget {
  const SemTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Você ainda não cadastrou nenhuma transferência!!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
