import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:developer' as dev;

import 'package:flutter/services.dart';

Future<List?> excelToJson() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xls', 'xlsx'],
    allowMultiple: false,
  );
  if (result != null) {
    Uint8List? bytes = result.files.single.bytes;
    Excel excel = Excel.decodeBytes(bytes!);
    int i = 0;
    List<dynamic> keys = [];
    var jsonMap = [];

    for (var table in excel.tables.keys) {
      dev.log(table.toString());
      for (var row in excel.tables[table]!.rows) {
        dev.log(row.toString());
        if (i == 0) {
          keys = row;
          i++;
        } else {
          Map<dynamic, dynamic> temp = {};
          int j = 0;
          String tk = '';
          for (Data key in keys) {
            tk = key.value.toString();
            temp[tk] = (row[j]!.value.runtimeType == String)
                ? '\"${row[j]!.value.toString()}\"'
                : row[j]!.value;
            j++;
          }

          jsonMap.add(temp);
        }
      }
    }
    // dev.log(
    //   jsonMap.length.toString(),
    //   name: 'excel to json',
    // );
    // dev.log(jsonMap.toString(), name: 'excel to json');
    // String fullJson =
    //     jsonMap.toString().substring(1, jsonMap.toString().length - 1);
    // dev.log(
    //   fullJson.toString(),
    //   name: 'excel to json',
    // );
    return jsonMap;
  }

  return null;
}

// Future<void> excelToJsonAgain(String fileName, String fileDirectory,GlobalKey<ScaffoldState> scaffoldKey) async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'csv']);
//
//   ByteData data = result?.files.first.bytes as ByteData;
//   var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   var excel = Excel.decodeBytes(bytes);
//   int i = 0;
//   List<dynamic> keys =[];
//   List<Map<String, dynamic>> json =[];
//   for (var table in excel.tables.keys) {
//     for (var row in excel.tables[table].rows) {
//       if (i == 0) {
//         keys = row;
//         i++;
//       } else {
//         Map<String, dynamic> temp = Map<String, dynamic>();
//         int j = 0;
//         String tk = '';
//         for (var key in keys) {
//           tk = '"' + key + '"';
//           temp[tk] = (row[j].runtimeType == String)
//               ? '"' + row[j].toString() + '"'
//               : row[j];
//           j++;
//         }
//         json.add(temp);
//       }
//     }
//   }
//   print(json.length);
//   String fullJson = json.toString().substring(1, json
//       .toString()
//       .length - 1);
//
//   fullJson = '{ "DATA" : [$fullJson]}';
//   final directory = await getExternalStorageDirectory();
//
//   File file = await File('${directory.path}/$fileName.json').create();
//   await file.writeAsString(fullJson).then((value) =>
//       scaffoldKey.currentState
//           .showSnackBar(SnackBar(content: Text("Completed")))
//   );
//   print(file.exists().toString());
// }
//
// Future<void> jsonToExcel(String fileName, String fileDirectory,GlobalKey<ScaffoldState> scaffoldKey) async{
//   String jsonString = await rootBundle.loadString(fileDirectory);
//
//   List<dynamic> jsonResult = jsonDecode(jsonString)["DATA"];
//
//
//   var excel = Excel.createExcel();
//   Sheet sheetObject = excel['Sheet1'];
//
//   Map<String,dynamic> result = jsonResult[0];
//   sheetObject.appendRow(result.keys.toList());
//
//   for(int i =0;i<jsonResult.length;i++){
//     Map<String,dynamic> result = jsonResult[i];
//     sheetObject.appendRow(result.values.toList());
//   }
//   final directory = await getExternalStorageDirectory();
//
//   excel.encode().then((onValue) {
//     File(("${directory.path}/$fileName.xlsx"))
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(onValue);
//     scaffoldKey.currentState
//         .showSnackBar(SnackBar(content: Text("Completed")));
//   });
//
//
//   print(sheetObject);
// }

void openFileExplorer() async {
  List<PlatformFile>? _paths;
  String? _extension="csv";
  FileType _pickingType = FileType.custom;
  try {

    _paths = (await FilePicker.platform.pickFiles(
      type: _pickingType,
      allowMultiple: false,
      allowedExtensions: (_extension.isNotEmpty)
          ? _extension.replaceAll(' ', '').split(',')
          : null,
    ))
        ?.files;
  } on PlatformException catch (e) {
    print("Unsupported operation" + e.toString());
  } catch (ex) {
    print(ex);
  }
  // if (!mounted) return;
  // setState(() {+
  final input = new File('a/csv/file.txt').openRead();
  final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    // openFile(_paths![0].path);
    // print(_paths);
    // print("File path ${_paths[0]}");
    // print(_paths.first.extension);
  //
  // });
}
openFile(filepath) async
{
  File f = new File(filepath);
  print("CSV to List");
  final input = f.openRead();
  final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
  print(fields);

}