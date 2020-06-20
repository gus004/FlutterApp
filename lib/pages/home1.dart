import 'package:flutter/material.dart';
import 'package:com/pages/configuracoes.dart';
import 'package:com/pages/temperatura.dart';
import 'package:com/pages/sobre.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override

  Widget _buildBottomCard(double width, double height){ //QUADRO AZUL EMBAIXO
    return Container(
      width: width,
      height: height/3,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16)
          )
      ),
      child: _buildBottomCardChildren(),
    );
  }

  Widget _buildBottomCardChildren(){ //PARTE DE BAIXO QUE TEM A LOGO
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Image.asset( "assets/images/logo.png" ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.3),
        title: Center(
          child: Text('HOME',
            style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCard(width, height)
            ),
            //_buildCardsList(),

            Container( //CONFIGURAÇÕES
              width: width,
              height: 100,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              margin: EdgeInsets.only(left: 32, right: 32, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 1
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.settings),
                  Text("Configurações",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlatButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                        builder: (context) => Configuracoes()
                      )
                    );
                  },
                      child: Icon(Icons.arrow_forward_ios)
                  ),
                ],
              ),
            ),

            Container( //TEMPERATURA
              width: width,
              height: 100,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: EdgeInsets.only(left: 32, right: 32, top: 120, bottom: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 1
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Text("Temperatura",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlatButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Temperatura()
                        )
                    );
                  },
                      child: Icon(Icons.arrow_forward_ios)
                  ),
                ],
              ),
            ),

            Container( //SOBRE
              width: width,
              height: 100,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              margin: EdgeInsets.only(left: 32, right: 32, top: 240, bottom: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 1
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.stars),
                  Text("Sobre",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlatButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Sobre()
                        )
                    );
                  },
                      child: Icon(Icons.arrow_forward_ios)
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}