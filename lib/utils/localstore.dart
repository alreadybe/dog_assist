import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

writeProfileImageAsBase64String(image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('profile_pic', base64Encode(await image.readAsBytes()));
}

readProfileImageAsBase64String() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String bytes = prefs.getString('profile_pic') ?? null;
  var decodedBytes = base64Decode(bytes);

  final path = await _getLocalPath;
  final file = File('$path/profile_image${DateTime.now()}.json');

  await file.writeAsBytes(decodedBytes);
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
