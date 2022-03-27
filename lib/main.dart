import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CsvToList());
}

class CsvToList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CsvToListState();
  }
}

class CsvToListState extends State<CsvToList> {
  List<List<dynamic>> employeeData = [];
  //

  Future LoadAsset() async {
    final myData = await rootBundle.loadString("./assets/test.csv");
    print(myData);
    employeeData = CsvToListConverter().convert(myData);
    print(employeeData);
    employeeData[0].add("Status");
    for (int i = 1; i < employeeData.length; i++) {
      employeeData[i].add(null);
    }
    print(employeeData);
    String newcsv = ListToCsvConverter().convert(employeeData);
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // List<PlatformFile>? _paths = [];
  // String? _extension = "csv";
  // FileType _pickingType = FileType.custom;
  @override
  void initState() {
    super.initState();
    employeeData = List<List<dynamic>>.empty(growable: true);
    LoadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Csv Read',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("CSV To List")),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     color: Colors.green,
            //     height: 30,
            //     // child: TextButton(
            //     //     child: Text(
            //     //       "Load Data",
            //     //       style: TextStyle(color: Colors.white),
            //     //     ),
            //     //     onPressed: () async {
            //     //       await LoadAsset();
            //     //     }),
            //   ),
            // ),
            Table(
              border: TableBorder.all(width: 5),
              children: employeeData.map((item) {
                return TableRow(
                    children: item.map((row) {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(row.toString()),
                  ));
                }).toList());
              }).toList(),
            ),
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: employeeData.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(employeeData[index][0]),
            //               Text(employeeData[index][1]),
            //               Text(employeeData[index][2]),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
  //
  // openFile(filepath) async {
  //   File f = new File(filepath);
  //   print("CSV to List");
  //   final input = f.openRead();
  //   final fields = await input
  //       .transform(utf8.decoder)
  //       .transform(new CsvToListConverter())
  //       .toList();
  //   print(fields);
  //   setState(() {
  //     employeeData = fields;
  //   });
  // }
  //
  // void _openFileExplorer() async {
  //   try {
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: false,
  //       allowedExtensions: (_extension?.isNotEmpty ?? false)
  //           ? _extension?.replaceAll(' ', '').split(',')
  //           : null,
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     openFile(_paths![0].path);
  //     print(_paths);
  //     print("File path ${_paths![0]}");
  //     print(_paths!.first.extension);
  //   });
  // }
}
