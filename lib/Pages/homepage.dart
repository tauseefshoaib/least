import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:http/http.dart';
import 'package:least/Services/barcodeDecoder.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var i = "Type or Scan";
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

  List itemFromFirebase = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade900,
        title: Text("Scanner TSaw"),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(i),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Type Value Manually"),
                onChanged: (value) {
                  setState(() {
                    i = value;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  setState(() {
                    barcode();
                  });
                },
                label: Text("Scan"),
                icon: Icon(Icons.qr_code_scanner),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (i.isEmpty ||
                  i == "Cannot send empty code" ||
                  i == "Type or Scan") {
                setState(() {
                  i = "Cannot send empty code";
                });
              } else {
                await post(
                    Uri.parse("https://api.tsaw.tech/v1/api/drone/drone-ready"),
                    body: jsonEncode({"droneId": i}));
              }
            },
            child: Text("Send Code"),
          ),
        ],
      ),
    );
  }
}
