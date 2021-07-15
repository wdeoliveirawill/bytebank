import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/biometry.dart';
import 'package:bytebank/models/customer.dart';
import 'package:bytebank/screen/dashboard/dashboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';

class SigninPage extends StatelessWidget {
  final _formUserKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final _formAddressKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final _formAuthKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Cliente"),
      ),
      body: Consumer<Customer>(
        builder: (context, customer, child) {
          return Stepper(
              currentStep: customer.actualStep,
              onStepContinue: () {
                final functions = [
                  _saveStep1,
                  _saveStep2,
                  _saveStep3,
                ];
                return functions[customer.actualStep](context);
              },
              onStepCancel: () {
                customer.actualStep =
                    customer.actualStep > 0 ? customer.actualStep - 1 : 0;
              },
              steps: _buildSteps(context, customer),
              controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                return Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        RaisedButton(
                          onPressed: onStepContinue,
                          child: Text(
                            "Salvar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                        ),
                        RaisedButton(
                          onPressed: onStepCancel,
                          color: Colors.grey,
                          child: Text(
                            "Voltar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ));
              });
        },
      ),
      /*body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
                
                ElevatedButton(
                  onPressed: () {
                    if (_formUserKey.currentState!.validate()) {
                      _saveData(context);
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
          key: _formUserKey,
        ),
      ),*/
    );
  }

  void _saveStep1(BuildContext context) {
    /*if (_formUserKey.currentState!.validate()) {
      Customer customer = Provider.of<Customer>(context, listen: false);
      customer.name = _nameController.text;
      _nextStep(context);
    }*/
    _nextStep(context);
  }

  void _saveStep2(BuildContext context) {
    /*if (_formAddressKey.currentState!.validate()) {
      _nextStep(context);
    }*/
    _nextStep(context);
  }

  void _saveStep3(BuildContext context) {
    if (_formAuthKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
          (route) => false);
    }
  }

  Step _buildStep1(BuildContext context, Customer customer) {
    return Step(
      title: Text("Seus dados"),
      isActive: customer.actualStep >= 0,
      content: Form(
        key: _formUserKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Nome",
              ),
              controller: _nameController,
              maxLength: 255,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.length < 3) {
                  return "Informe pelo menos um sobrenome";
                }
                if (!value.contains(" ")) {
                  return "Informe pelo menos um sobrenome";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
              controller: _emailController,
              maxLength: 255,
              validator: (value) =>
                  Validator.email(value) ? "Email inválido" : null,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "CPF",
              ),
              controller: _cpfController,
              maxLength: 14,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.cpf(value) ? "CPF inválido" : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Celular",
              ),
              controller: _phoneController,
              maxLength: 14,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.phone(value) ? "Celular inválido" : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            DateTimePicker(
              controller: _birthdayController,
              type: DateTimePickerType.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              dateLabelText: "Nascimento",
              dateMask: "dd/MM/yyyy",
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.isEmpty) {
                  return "Data inválida";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Step _buildStep2(BuildContext context, Customer customer) {
    return Step(
      title: Text("Dados de Endereço"),
      isActive: customer.actualStep >= 1,
      content: Form(
        key: _formAddressKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "CEP",
              ),
              controller: _zipcodeController,
              maxLength: 11,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.cep(value) ? "CEP inválido" : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
            ),
            DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(labelText: "Estado"),
              items: Estados.listaEstadosSigla.map((String uf) {
                return DropdownMenuItem(
                  child: Text(uf),
                  value: uf,
                );
              }).toList(),
              onChanged: (value) {
                _stateController.text = "$value";
              },
              validator: (value) {
                if (value == null) {
                  return "Selecione um estado";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Cidade",
              ),
              controller: _cityController,
              maxLength: 255,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.length == 1) {
                  return "Cidade inválida";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Bairro",
              ),
              controller: _districtController,
              maxLength: 255,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.length == 1) {
                  return "Bairro inválido";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Endereço",
              ),
              controller: _addressController,
              maxLength: 255,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.length == 1) {
                  return "Endereço inválido";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Número",
              ),
              controller: _numberController,
              maxLength: 255,
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  Step _buildStep3(BuildContext context, Customer customer) {
    return Step(
      title: Text("Dados de autenticação"),
      isActive: customer.actualStep >= 2,
      content: Form(
        key: _formAuthKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Senha",
              ),
              controller: _passController,
              obscureText: true,
              maxLength: 255,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value.length < 4) {
                  return "Senha muito curta";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirmação de Senha",
              ),
              controller: _passConfirmController,
              obscureText: true,
              maxLength: 255,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null) {
                  return null;
                }
                if (value != _passController.text) {
                  return "Senhas não conferem";
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Para prosseguir com o seu cadastro é necessário que tenhamos uma foto do seu RG",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () => _captureRg(context),
              child: Text("Tirar foto do meu RG"),
            ),
            _isRgSet(context) ? _showRg(context) : _askRg(context),
            Biometry(),
          ],
        ),
      ),
    );
  }

  List<Step> _buildSteps(BuildContext context, Customer customer) {
    final List<Step> steps = [
      _buildStep1(context, customer),
      _buildStep2(context, customer),
      _buildStep3(context, customer),
    ];
    return steps;
  }

  _nextStep(BuildContext context) {
    Customer customer = Provider.of<Customer>(context, listen: false);
    goTo(customer.actualStep + 1, customer);
  }

  void goTo(int step, Customer customer) {
    customer.actualStep = step;
  }

  void _saveData(BuildContext context) {
    Customer customer = Provider.of<Customer>(context, listen: false);
    customer.name = _nameController.text;
  }

  void _captureRg(BuildContext context) async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    Provider.of<Customer>(context, listen: false).imageRg =
        File(pickedFile!.path);
  }

  Column _askRg(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Foto do RG pendente",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      );

  bool _isRgSet(BuildContext context) =>
      Provider.of<Customer>(context, listen: false).imageRg != null;

  Image _showRg(BuildContext context) =>
      Image.file(Provider.of<Customer>(context, listen: false).imageRg);
}
