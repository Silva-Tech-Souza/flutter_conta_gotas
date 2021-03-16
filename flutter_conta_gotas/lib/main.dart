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
Color corbtn_gotas;
int cor;


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
    print("$corbtn_gotas  +  ----- +    $oldColor");

    return oldColor;
  }

  Color _getColor(Uint32List words, double x1, double y1) {
    int x = x1.toInt();
    int y = y1.toInt();
    var offset = x + y * imageWidth;
    print("$corbtn_gotas  +  ----- +    $oldColor");

    return Color(words[offset]);
  }

  void _ondtap(Offset offset, GlobalKey key) async {
    corbtn_gotas = await capturePng(key, Offset(offset.dx, offset.dy));
    print("$corbtn_gotas  +  ----- +    $oldColor");
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
      body: RepaintBoundary(
        key: floodFillKey,
        child: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new GestureDetector(
            onTapDown: (TapDownDetails detail) {
              _ondtap(detail.globalPosition, floodFillKey);
              setState(() {
                corbtn_gotas = oldColor;
                cor = int.parse(corbtn_gotas.toString());
                print(cor);
                tipo = 1;

               
              });
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.red,
                    child: Text("dfsdf"),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Text("dfsdf"),
                  ),
                ],
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
