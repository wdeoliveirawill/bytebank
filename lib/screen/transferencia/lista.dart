import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'formulario.dart';

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioTransferencia(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<Transferencias>(
        builder: (context, transferencias, child) {
          return ListView.builder(
            itemCount: transferencias.transferencias.length,
            itemBuilder: (context, index) {
              final transf = transferencias.transferencias[index];
              return ItemTransferencia(transf);
            },
          );
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(
    this._transferencia,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
