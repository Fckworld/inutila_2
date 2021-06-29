import 'package:flutter/material.dart';
import 'package:flutter_entrega_2/%20provaiders/autos_provider.dart';
import 'package:flutter_entrega_2/models/autoModel.dart';
import 'package:flutter_entrega_2/pages/body.dart';

class ListaAutos extends StatefulWidget {
  static String id = 'Listado';

  @override
  _ListAutosState createState() => _ListAutosState();
}

class _ListAutosState extends State<ListaAutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Body.id);
            },
          ),
        ],
        title: Text('Listado de autos'),
      ),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: AutosProvider().cargarAutos(),
      builder: (BuildContext context, AsyncSnapshot<List<AutoModel>> snapshot) {
        if (snapshot.hasData) {
          final autos = snapshot.data;

          return ListView.builder(
            itemCount: autos.length,
            itemBuilder: (context, i) => _crearItem(context, autos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, AutoModel auto) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('${auto.marca} - ${auto.precio}'),
              onTap: () {
                Navigator.pushNamed(context, Body.id, arguments: auto)
                    .then((value) {
                  setState(() {});
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    AutosProvider().borrarAuto(auto.id);
                    mostrarMensaje('Auto borrado, actualice');
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }

  Widget botonBack() {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {
          Navigator.pushNamed(context, Body.id);
        },
        child: Text(
          'Regresar',
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }

  void mostrarMensaje(String texto) {
    final msg = SnackBar(
      content: Text(texto),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(msg); //muestra mensaje rapido en el snackbar
  }
}
