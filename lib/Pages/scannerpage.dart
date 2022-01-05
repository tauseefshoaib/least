import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class ScannerPage extends StatefulWidget {
  var initialValue = "Hi";

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  var i = "hi";
  var barcodeDecoder;
  void getName() async {
    i = barcodes[0].displayValue;
    print(i);
  }

  List<Barcode> barcodes = [];
  void barcode() async {
    print("object");
    try {
      barcodes = await FlutterMobileVision.scan(
        fps: 15.0,
      );
      print("barcode scan");
      getName();
      print("getname called");
      setState(() {});
    } on Exception {
      barcodes.add(new Barcode('Failed to get barcode.'));
    }
  }

  bool initialized = false;
  List grocery = [];
  String item = "";
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((x) => setState(() {
          initialized = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(i),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                key: Key(widget.initialValue),
                initialValue: widget.initialValue,
                onChanged: (value) => i = value,
              ),
            ),
          ),
          Row(
            children: [
              FlatButton(
                  onPressed: () {
                    setState(() {
                      barcode();
                    });
                  },
                  child: Text("Scan")),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.send),
                label: Text("send"),
              )
            ],
          )
        ],
      ),
    );
  }
}
