import 'package:bytebank/components/form_item_field.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioDeposito extends StatefulWidget {
  const FormularioDeposito({Key? key}) : super(key: key);

  @override
  _FormularioDepositoState createState() => _FormularioDepositoState();
}

class _FormularioDepositoState extends State<FormularioDeposito> {
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receber depósito"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormItemField(
              controller: _valorController,
              label: "Valor",
              hint: "0.00",
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => criaDeposito(context),
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }

  criaDeposito(BuildContext context) {
    final double? valor = double.tryParse(_valorController.text);
    if (valor != null) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _atualizaEstado(context, valor) {
    final Saldo saldo = Provider.of<Saldo>(context, listen: false);
    saldo.adiciona(valor);
  }
}
