import 'package:flutter/material.dart';
import 'package:flutter_entrega_2/models/car.dart';
import 'package:flutter_entrega_2/pages/list.dart';

import 'DBHelper.dart';

class Body extends StatefulWidget {
  static String id = 'Body';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  String marca;
  var dbHelper;
  bool isUpdating;
  Future<List<Car>> cars;
  String patente;
  String precio;
  int curCarId;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      cars = dbHelper.getCars();
    });
  }

  clearName() {
    controller.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Car e = Car(curCarId, patente, marca, precio);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Car e = Car(null, patente, marca, precio);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Patente'),
              validator: (val) => val.length == 0 ? 'Ingrese nombre' : null,
              onSaved: (val) => marca = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: cars,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  SingleChildScrollView dataTable(List<Car> cars) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('MARCA'),
          ),
          DataColumn(
            label: Text('BORRAR'),
          )
        ],
        rows: cars
            .map(
              (car) => DataRow(cells: [
                DataCell(
                  Text(car.marca), //QUIZAS TENGA QUE AGREGAS ,AS CAMPOS
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curCarId = car.id;
                    });
                    controller.text = car.marca;
                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dbHelper.delete(car.id);
                    refreshList();
                  },
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Text('Patente'),
                form(),
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
          Navigator.pushNamed(context, Lista.id);
        },
        child: Text(
          a,
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }
}
