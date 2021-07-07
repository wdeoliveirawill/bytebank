import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/widgets.dart';

class Transferencias extends ChangeNotifier {
  final List<Transferencia> _transferencias = [];

  List<Transferencia> get transferencias => _transferencias;

  List<Transferencia> get ultimasTransferencias =>
      _transferencias.reversed.toList();

  void adiciona(Transferencia transferencia) {
    transferencias.add(transferencia);
    notifyListeners();
  }
}
