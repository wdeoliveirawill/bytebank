import 'package:bytebank/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometry extends StatelessWidget {
  final _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isAvailable(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Text(
                    "Habilitar login por biometria?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await authenticate(context);
                    },
                    child: Text("Habilitar"),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }

  Future<bool> _isAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (err) {}
    return false;
  }

  Future<void> authenticate(BuildContext context) async {
    bool authenticated = false;
    authenticated = await _localAuth.authenticate(
      localizedReason: "Por favor autentique-se via biometria",
      useErrorDialogs: true,
    );
    Provider.of<Customer>(context, listen: false).biometry = authenticated;
  }
}
