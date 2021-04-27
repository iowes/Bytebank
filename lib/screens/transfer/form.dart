import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Criando Transferência';
const _accountField = 'Numero da conta';
const _accountFieldHint = '0000';
const _valueField = 'Valor';
const _valueFieldHint = '0000';
const _buttonText = 'Confirmar';

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _fieldAccountController = TextEditingController();
  final TextEditingController _fieldValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controller: this._fieldAccountController,
                labelText: _accountField,
                hintText: _accountFieldHint),
            Editor(
                controller: this._fieldValueController,
                labelText: _valueField,
                hintText: _valueFieldHint,
                icon: Icons.monetization_on),
            ElevatedButton(
              child: Text(_buttonText),
              onPressed: () => _createTransfer(context),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_fieldAccountController.text);
    final double value = double.tryParse(_fieldValueController.text);
    if (accountNumber != null && value != null) {
      final transfer = Transfer(value, accountNumber);
      debugPrint('$transfer');
      Navigator.pop(context, transfer);
    }
  }
}
