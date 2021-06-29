import 'package:flutter/material.dart';
import 'package:flutter_entrega_2/models/autoModel.dart';
import 'package:flutter_entrega_2/pages/list.dart';
import 'package:flutter_entrega_2/ provaiders/autos_provider.dart';

class Body extends StatefulWidget {
  static String id = 'Body';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AutoModel auto = new AutoModel();
  bool _guardando = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AutoModel autData = ModalRoute.of(context).settings.arguments;
    if (autData != null) {
      auto = autData;
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Center(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          patente('Patente'),
                          marca('Marca'),
                          precio('Precio'),
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
                )
              ],
            )),
      ),
    );
  }

  Widget patente(String a) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          a,
          style: TextStyle(fontSize: 20),
        ),
        TextFormField(
          initialValue: auto.patente,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onSaved: (valor) {
            auto.patente = valor;
          },
          validator: (value) {
            if (value.length < 1) {
              return 'Ingrese patente';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  Widget marca(String a) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          a,
          style: TextStyle(fontSize: 20),
        ),
        TextFormField(
          initialValue: auto.marca,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onSaved: (valor) {
            auto.marca = valor;
          },
          validator: (value) {
            if (value.length < 1) {
              return 'Ingrese marca';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  bool isNumeric(String s) {
    if (s.isEmpty) return false;
    final n = num.tryParse(s);
    if (n == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget precio(String a) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          a,
          style: TextStyle(fontSize: 20),
        ),
        TextFormField(
          initialValue: auto.precio.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onSaved: (valor) {
            auto.precio = double.parse(valor);
          },
          validator: (valor) {
            if (isNumeric(valor)) {
              return null;
            } else {
              return 'Ingrese solo numeros';
            }
          },
        ),
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save(); //Este save, ejecuta todos los OnSave(value) de
    //su formulario correspondiente.
    setState(() {});

    if (auto.id == null) {
      AutosProvider().crearAuto(auto);
    } else {
      AutosProvider().editarAuto(auto);
    }

    //En esta funcion subo el producto a firebase.
    mostrarMensaje('¡Producto Agregado!');
    //Ejecutar un proceso
  }

  void mostrarMensaje(String texto) {
    final msg = SnackBar(
      content: Text(texto),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(msg); //muestra mensaje rapido en el snackbar
  }

  Widget botonGuardar(String a) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {
          if (_guardando) {
            return null;
          } else {
            _submit();
            Navigator.pushNamed(context, Body.id);
          }
        }, //(_guardando) ? null : _submit,
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
          Navigator.pushNamed(context, ListaAutos.id);
        },
        child: Text(
          a,
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }
}
