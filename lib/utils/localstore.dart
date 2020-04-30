import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _getLocalPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(entity) async {
  final path = await _getLocalPath;
  final file = File('$path/$entity.json');
  if (!await file.exists()) {
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode([]));
  }

  return file;
}

writeData(data, entity) async {
  final file = await _localFile(entity);
  var currentData = jsonDecode(await file.readAsString());
  currentData.add(data);
  return await file.writeAsString(jsonEncode(currentData));
}

readData(entity) async {
  final file = await _localFile(entity);
  if (await file.exists()) {
    var data = await file.readAsString();
    if (data.length > 0) {
      return jsonDecode(data);
    }
  }
  return [];
}
