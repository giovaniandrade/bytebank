import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '000';
const _textoBotaoConfirmar = 'Confirmar';

// Usando multi providers não precisa mais ser um StatefulWidget
// class FormularioTransferencia extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return FormularioTransferenciaState();
//   }
// }

class FormularioTransferencia extends StatelessWidget {
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
                icone: Icons.monetization_on_outlined,
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
    final transferenciaValida =
        _validaTransferencia(context, numeroConta, valor);

    if (transferenciaValida) {
      final novaTransferencia = Transferencia(valor!, numeroConta!);

      // Log
      debugPrint('$novaTransferencia');

      // Log ou msg pro usuário
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$novaTransferencia')));

      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
  }

  _validaTransferencia(context, numeroConta, valor) {
    final _saldoSuficiente = valor <=
        Provider.of<Saldo>(
          context,
          listen: false,
        ).valor;
    return _saldoSuficiente && numeroConta != null && valor != null;
  }

  _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }

// Antes de usar providers era assim:
// void _criaTransferencia(BuildContext context) {
//   debugPrint('clicou no confirmar');
//   debugPrint(_controladorCampoNumeroConta.text);
//   debugPrint(_controladorCampoValor.text);
//
//   final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
//   final double? valor = double.tryParse(_controladorCampoValor.text);
//
//   if (numeroConta != null && valor != null) {
//     final transferenciaCriada = Transferencia(valor, numeroConta);
//
//     // Log
//     debugPrint('$transferenciaCriada');
//
//     // Log ou msg pro usuário
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('$transferenciaCriada')));
//
//     Navigator.pop(context, transferenciaCriada);
//   }
// }
}
