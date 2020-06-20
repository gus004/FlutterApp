import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {

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
          child: Text('SOBRE',
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
              height: height/2,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Eletrontech Tecnologia em Eletrônica",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Text("CNPJ: 09.081.958.0001-29",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Telefone: (54) 3632-7161",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_outline),
                      Text("  Alessandro Fonseca",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text("Versão 1.0",
                      style: TextStyle(fontSize: 20),
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