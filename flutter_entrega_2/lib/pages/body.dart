import 'package:flutter/material.dart';
import 'package:flutter_entrega_2/pages/list.dart';

class Body extends StatefulWidget {
  static String id = 'Body';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 200,
            child: Column(
              children: [
                textoYBoton('Patente'),
                textoYBoton('Marca'),
                textoYBoton('Precio'),
                SizedBox(
                  height: 30,
                ),
                botonGuardar('Guardar'),
                SizedBox(
                  height: 30,
                ),
                botonListado('Listado'),
              ],
            )),
      ),
    );
  }

  Widget textoYBoton(String a) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          a,
          style: TextStyle(fontSize: 20),
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget botonGuardar(String a) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {},
        child: Text(
          a,
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }

  Widget botonListado(String a) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {
          Navigator.pushNamed(context, List.id);
        },
        child: Text(
          a,
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }
}
