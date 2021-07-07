import 'package:bytebank/components/form_item_field.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _numeroContaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando Transferência"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormItemField(
              controller: _numeroContaController,
              label: "Número da conta",
              hint: "0000",
            ),
            FormItemField(
              controller: _valorController,
              label: "Valor",
              hint: "0.00",
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => criaTransferencia(context),
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }

  void criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);
    final Saldo saldo = Provider.of<Saldo>(context, listen: false);

    if (valor != null && numeroConta != null && saldo.valor >= valor) {
      final transferencia = Transferencia(valor, numeroConta);
      atulizaEstado(context, transferencia, saldo);
      Navigator.pop(context);
    }
  }

  void atulizaEstado(
      BuildContext context, Transferencia transferencia, Saldo saldo) {
    final Transferencias transferencias =
        Provider.of<Transferencias>(context, listen: false);

    transferencias.adiciona(transferencia);
    saldo.subtrai(transferencia.valor);
  }
}
