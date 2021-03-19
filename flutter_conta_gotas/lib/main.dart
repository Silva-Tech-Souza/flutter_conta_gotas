import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

GlobalKey floodFillKey = new GlobalKey();
Uint32List words;
int width;
Color oldColor, pixel;
int imageWidth;
int imageHeight;
int tipo;
String cores_inversa, controle;
int cores_inversa2;
Color corbtn_gotas;
Color cor;
String r, g, b;
List<String> cores, cores2;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Color> capturePng(GlobalKey key, Offset offset) async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final rgbaImageData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    imageHeight = image.height;
    imageWidth = image.width;
    words = Uint32List.view(rgbaImageData.buffer, rgbaImageData.offsetInBytes,
        rgbaImageData.lengthInBytes ~/ Uint32List.bytesPerElement);
    oldColor = _getColor(words, offset.dx, offset.dy);
    corbtn_gotas = oldColor;
    cores = corbtn_gotas.toString().split('xff');
    cores2 = cores[1].toString().split(')');
    cores_inversa = cores2[0].toString().split('').reversed.join('');
    controle = "Color(0xff$cores_inversa)";

    print('$oldColor');
    return oldColor;
  }

  Color _getColor(Uint32List words, double x1, double y1) {
    int x = x1.toInt();
    int y = y1.toInt();
    var offset = x + y * imageWidth;
    /* controle = words[offset].toString();
      cores = controle.split('xff');
      cores_inversa = "0xff" + cores[1].toString().split('').reversed.join('');
      cores_inversa2 = int.parse(cores_inversa);
      cor = Color(cores_inversa2);*/

    return Color(words[offset]);
  }

  void ondtap(Offset offset, GlobalKey key) async {
    capturePng(key, Offset(offset.dx, offset.dy)).then((data) {
      setState(() {
        corbtn_gotas = oldColor;
        cores = corbtn_gotas.toString().split('xff');
        cores2 = cores[1].toString().split(')');
    
       
                  r =
                      cores2[0].toString().substring(0, 2);
		  g  =
                      cores2[0].toString().substring(2, 4);
		b  =
                      cores2[0].toString().substring(4, 6);
                  controle = "Color(0xff$b$g$r)";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    corbtn_gotas = Colors.blue;
    tipo = 0;
  }

  @override
  Widget build(BuildContext context) {
    // var sizeH = MediaQuery.of(context).size.height;
    //var sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: RepaintBoundary(
          key: floodFillKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: GestureDetector(
              onTapDown: (TapDownDetails detail) {
                ondtap(detail.globalPosition, floodFillKey);
                setState(() {
                  corbtn_gotas = oldColor;
                  cores = corbtn_gotas.toString().split('xff');
                  cores2 = cores[1].toString().split(')');
                  r =
                      cores2[0].toString().split('').reversed.join('');
                  
                  r =
                      cores2[0].toString().substring(0, 2);
		  g  =
                      cores2[0].toString().substring(2, 4);
		b  =
                      cores2[0].toString().substring(4, 6);
                  controle = "Color(0xff$b$g$r)";
                });
              },
              onPanUpdate: (DragUpdateDetails details) {
                ondtap(details.globalPosition, floodFillKey);
                setState(() {
                  corbtn_gotas = oldColor;
                  cores = corbtn_gotas.toString().split('xff');
                  cores2 = cores[1].toString().split(')');
                  r =
                      cores2[0].toString().substring(0, 2);
		  g  =
                      cores2[0].toString().substring(2, 4);
		b  =
                      cores2[0].toString().substring(4, 6);
                  controle = "Color(0xff$b$g$r)";
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: Color(0xFFAC1313),
                      child: Text("$corbtn_gotas  +  ----- + $controle "),
                    ),
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: Color(0xFF71F311),
                      child: Text("$corbtn_gotas  +  ----- +   "),
                    ),
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: Color(0xFFF103B9),
                      child: Text(
                          "$corbtn_gotas  +  ----- + $cores + ---- $cores_inversa "),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: Color(0xFF7103A9),
                      child: Text("$corbtn_gotas  +  ----- +  $cores2 "),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: corbtn_gotas,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
