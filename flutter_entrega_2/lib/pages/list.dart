import 'package:flutter/material.dart';
import 'package:flutter_entrega_2/pages/body.dart';

class Lista extends StatefulWidget {
  static String id = 'Listado';

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text('Patente'),
                Text('Marca'),
                Text('Precio'),
                botonBack(),
              ],
            ),
          )
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
}
