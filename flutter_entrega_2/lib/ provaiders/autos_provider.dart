import 'dart:convert';
import 'dart:io';
import 'package:flutter_entrega_2/models/autoModel.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart'; //Para MediaType de la funcion _subirImagen

class AutosProvider {
  //Url para conectarme a firebase en mi link del proyecto.
  final String _url = 'https://duoc-auto-default-rtdb.firebaseio.com/';

  Future<bool> crearAuto(AutoModel auto) async {
    //Url de la tabla con la que trabajare.
    final url = '$_url/autos.json';
    final respuesta = //Este String es el modelo, que toma los valores de producto.
        await http.post(Uri.parse(url), body: autoModelToJson(auto));
    final decodeData = json.decode(respuesta.body);
    print(decodeData);
    //Una vez que termina todo retorno true
    //no hay exception acá
    return true;
  }

  Future<List<AutoModel>> cargarAutos() async {
    final url = '$_url/autos.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<AutoModel> autos = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, aut) {
      final autTemp = AutoModel.fromJson(aut);
      autTemp.id = id;
      autos.add(autTemp);
    });
    // print( productos[0].id );
    return autos;
  }

  Future<int> borrarAuto(String id) async {
    final url = '$_url/autos/$id.json';
    final resp = await http.delete(Uri.parse(url));

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/stapiaduocuc/image/upload?upload_preset=vfdnkowbds');
    //mimeType me permite identificar con que tipo de archivo estamos trabajando.
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    //MultipartFile para subir un archivo
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    //Aqui tomo la url desde el archivo json que se genera en la apiicloud
    return respData['secure_url'];
  }

  Future<bool> editarAuto(AutoModel auto) async {
    //Url de la tabla con la que trabajare.
    final url = '$_url/autos/${auto.id}.json';
    final respuesta = //Este String es el modelo, que toma los baores de producto.
        await http.put(Uri.parse(url), body: autoModelToJson(auto));
    final decodeData = json.decode(respuesta.body);
    print(decodeData);
    //Una vez que termina todo retorno true
    //no hay exception acá
    return true;
  }
}
