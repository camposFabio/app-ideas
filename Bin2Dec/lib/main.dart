import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary to Decimal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Binary to Decimal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _decimal = 0;

  final textController = TextEditingController();

  void _binaryToDecimal(String txtBinary) {
    setState(() {
      _decimal = 0;
      for (int i = 0; i < txtBinary.length; i++) {
        int _pos = txtBinary.length - i - 1;
        _decimal += int.parse(txtBinary[_pos]) * pow(2, i);
      }
    });
  }

  void _clearAll() {
    textController.clear();
    _binaryToDecimal("0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clearAll,
            tooltip: "Refresh",
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter the binary value:',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
                Divider(),
                TextFormField(
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[01]"))
                  ],
                  onChanged: (text) => _binaryToDecimal(text),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Binary value"),
                  controller: textController,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                ),
                Divider(),
                Text(
                  'Decimal value: $_decimal',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
