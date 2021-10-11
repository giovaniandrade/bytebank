import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '000';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                _controladorCampoNumeroConta,
                _rotuloCampoNumeroConta,
                _dicaCampoNumeroConta,
              ),
              Editor(
                _controladorCampoValor,
                _rotuloCampoValor,
                _dicaCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                onPressed: () => _criaTransferencia(context),
                child: Text(_textoBotaoConfirmar),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    debugPrint('clicou no confirmar');
    debugPrint(_controladorCampoNumeroConta.text);
    debugPrint(_controladorCampoValor.text);

    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);

      // Log
      debugPrint('$transferenciaCriada');

      // Log ou msg pro usuário
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$transferenciaCriada')));

      Navigator.pop(context, transferenciaCriada);
    }
  }
}
