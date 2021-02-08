import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'hello world',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Rutas()
        //MyHomePage(title: 'hellow world'),
        );
  }
}

class Rutas extends StatefulWidget {
  @override
  _Showroutes createState() => _Showroutes();
}

class ShapePainter extends CustomPainter {
  var pasos = 2;

  void segmentos(List lista) {
    pasos = lista.length;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List coloreo = [
      Colors.amber,
      Colors.pink,
      Colors.grey,
      Colors.red,
      Colors.blue
    ];
    Random rand = new Random();
    int index = rand.nextInt(5);
    var espacios = (size.width / pasos);
    var espaciado = 0;

    for (var i = 0; i < pasos; i++) {
      var line = Paint()
        ..color = coloreo[index]
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      Offset startingPoint = Offset(espaciado.toDouble() + 10, size.height / 2);
      Offset endingPoint = Offset((espaciado + espacios), size.height / 2);
      canvas.drawLine(startingPoint, endingPoint, line);

      var box = Paint()
        ..color = coloreo[index]
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      final rect = RRect.fromLTRBAndCorners(
          (espaciado.toDouble()),
          (size.height / 2) + 15,
          espaciado.toDouble() + 60,
          (size.height / 2) - 17,
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8));

      canvas.drawRRect(rect, box);

      var styletext = TextStyle(color: Colors.black87, fontSize: 18);

      var word = TextSpan(text: "A 110", style: styletext);
      var txt = TextPainter(text: word, textDirection: TextDirection.ltr);
      txt.layout(minWidth: 0, maxWidth: 50);

      txt.paint(
          canvas, Offset(espaciado.toDouble() + 5, (size.height / 2) - 13));
      espaciado += espacios.toInt();
      index = rand.nextInt(5);
    }
    var circulo_1 = Paint()
      ..color = Colors.amber
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    var circulo_2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width - 18, size.height / 2);
    canvas.drawCircle(center, 20, circulo_1);
    canvas.drawCircle(center, 15, circulo_2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _Showroutes extends State<Rutas> {
  final List<Widget> routes = <Widget>[];

  Widget build_trips() {
    ShapePainter().segmentos([1, 2, 3, 4]);
    return Scaffold(
      body: CustomPaint(
        painter: ShapePainter(),
        child: Container(),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      borderRadius: BorderRadius.circular(20),
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      maxWidth: 600,
      debounceDelay: const Duration(milliseconds: 300),
      onQueryChanged: (query) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.grey,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: Colors.black12);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          build_trips(),
          buildFloatingSearchBar(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.black45),
          BottomNavigationBarItem(
              icon: Icon(Icons.call_split_rounded),
              label: 'Viajes',
              backgroundColor: Colors.black45),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_up_rounded),
              label: '',
              backgroundColor: Colors.black45),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_rounded),
              label: 'pasajes',
              backgroundColor: Colors.black45),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Mi cuenta',
              backgroundColor: Colors.black45)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner_rounded),
        backgroundColor: Colors.amber[700],
      ),
    );
    /*bottomNavigationBar: BottomAppBar(
          color: Colors.orange[300],
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => {},
              ),
            ],
          )),*/
  }
}
