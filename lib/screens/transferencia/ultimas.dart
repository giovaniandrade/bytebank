import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final String _titulo = 'Últimas transferências';

class UltimasTransferencias extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _titulo,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final _ultimasTransferencias = transferencias.transferencias.reversed.toList();
            final int _quantidade = _ultimasTransferencias.length < 4 ? _ultimasTransferencias.length : 3;

            if(_quantidade == 0) {
              return SemTransferenciaCadastrada();
            }

            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _quantidade,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, indice) {
                  return ItemTransferencia(
                      _ultimasTransferencias[indice]);
                });
          },
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ListaTransferencias();
              }),
            );
          },
          child: Text('Ver todas transferências'),
        ),
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  const SemTransferenciaCadastrada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40.0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text('Sem transferências'),
      ),
    );
  }
}
