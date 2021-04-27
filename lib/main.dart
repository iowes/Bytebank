import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _fieldAccountController = TextEditingController();
  final TextEditingController _fieldValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: [
          Editor(
              controller: this._fieldAccountController,
              labelText: "Numero da conta",
              hintText: "0000"),
          Editor(
              controller: this._fieldValueController,
              labelText: "Conta",
              hintText: "0000",
              icon: Icons.monetization_on),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () => _createTransfer(context),
          )
        ],
      ),
    );
  }
  
  void _createTransfer(BuildContext context) {
    final int accountNumber =
    int.tryParse(_fieldAccountController.text);
    final double value = double.tryParse(_fieldValueController.text);
    if (accountNumber != null && value != null) {
      final transfer = Transfer(value, accountNumber);
      debugPrint('$transfer');
      Navigator.pop(context, transfer);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;

  const Editor({this.controller, this.labelText, this.hintText, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            labelText: labelText,
            hintText: hintText),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: Column(
        children: [
          TransferItem(
            transfer: Transfer(100, 1234),
          ),
          TransferItem(
            transfer: Transfer(200, 1234),
          ),
          TransferItem(
            transfer: Transfer(400, 1234),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transfer> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));

          future.then((transfer) => {
            debugPrint('$transfer')
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  const TransferItem({Key key, this.transfer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(transfer.value.toString()),
        subtitle: Text(transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  @override
  String toString() {
    return 'Transfer {value: $value, accountNumber: $accountNumber }';
  }

  Transfer(this.value, this.accountNumber);
}
