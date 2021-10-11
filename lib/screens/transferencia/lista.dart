import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {


  // widget: esse objeto é o state que foi definido no generics
  @override
  Widget build(BuildContext context) {
    // Testando
    //widget._transferencias.add(Transferencia(10, 54));
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future<Transferencia?> future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }));
            future.then((transferenciaRecebida) => _atualiza(transferenciaRecebida));

            // Isso poderia ser assim:
            // Navigator.push( ... )
            // .then( ... )
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    debugPrint('Aguardando 3 segundos...');
    Future.delayed(Duration(seconds: 3), () {
      debugPrint('$transferenciaRecebida');
      if (transferenciaRecebida != null) {
        // Em Widgets Stateful esse método é o mais importante
        setState(() {
          debugPrint('Adicionou');
          widget._transferencias.add(transferenciaRecebida);
        });
      }
    });
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}