import 'package:flutter/material.dart';

class body extends StatefulWidget {
  const body({Key key}) : super(key: key);

  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            Text('Patente'),
            TextField(
              decoration: InputDecoration(
                helperText: 'asdsad',
                hintText: 'FFFF',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 100),
            Text('Marca'),
            SizedBox(height: 100),
            Text('Precios'),
          ],
        ),
      ),
    );
  }
}
