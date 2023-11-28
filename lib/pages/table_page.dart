import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:

    Scaffold(
      appBar: AppBar(title: const Text("Table"),),
      body: Scrollbar(
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                border: TableBorder.all(color: Colors.grey.shade200, width: 5),
                children: const [
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Title 1',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Title 2',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Title 3',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Title 4',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Value 1',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Value 2',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Value 3',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                            child: Text(
                              'Value 4',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ))),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
