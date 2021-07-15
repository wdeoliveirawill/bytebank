import 'dart:io';

import 'package:flutter/widgets.dart';

class Customer extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _cpf;
  String? _birthday;
  String? _zipcode;
  String? _state;
  String? _city;
  String? _address;
  String? _number;
  String? _password;
  int _actualStep = 0;
  File? _imageRG = null;
  bool _biometry = false;

  get name => this._name;

  set name(value) => this._name = value;

  get email => this._email;

  set email(value) => this._email = value;

  get phone => this._phone;

  set phone(value) => this._phone = value;

  get cpf => this._cpf;

  set cpf(value) => this._cpf = value;

  get birthday => this._birthday;

  set birthday(value) => this._birthday = value;

  get zipcode => this._zipcode;

  set zipcode(value) => this._zipcode = value;

  get state => this._state;

  set state(value) => this._state = value;

  get city => this._city;

  set city(value) => this._city = value;

  get address => this._address;

  set address(value) => this._address = value;

  get number => this._number;

  set number(value) => this._number = value;

  get password => this._password;

  set password(value) => this._password = value;

  get actualStep => this._actualStep;

  set actualStep(value) {
    this._actualStep = value;
    notifyListeners();
  }

  get imageRg => this._imageRG;

  set imageRg(value) {
    this._imageRG = value;
    notifyListeners();
  }

  get biometry => this._biometry;

  set biometry(value) {
    this._biometry = value;
    notifyListeners();
  }
}
