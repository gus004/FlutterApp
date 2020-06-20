import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _idController = TextEditingController();
  TextEditingController _offsetController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  String _erroMsg = "";
  File _foto;

  _validacao() {
    String id = _idController.text;
    String offset = _offsetController.text;
    String hora = _horaController.text;

    if(id.isNotEmpty && offset.isNotEmpty && hora.isNotEmpty) {
      _cadastrar();
    } else {
      setState(() {
        _erroMsg = "Preencha todos os campos!";
      });
    }
  }

  Future _cadastrar() async {
    String id = _idController.text;
    String offset = _offsetController.text;
    String hora = _horaController.text;

    String newConfig;
    FirebaseUser user;

    await FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != null) user = currentUser
    });

    await Firestore.instance
        .collection(user.uid)
        .document("configuracoes")
        .collection("configuracoes")
        .add({
          "id": id,
          "offset": offset,
          "hora": hora,
    }).then((value) {
      newConfig = value.documentID;
    });

    print("ID DOC: "+newConfig);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: _image(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _title(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _content(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _action(),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage( //FUNDO
            image: AssetImage("assets/images/fundo.jpg"),
            fit: BoxFit.cover,
          )
      ),
    );
  }

  Widget _action() {
    return Container( //ADICIONAR
      width: 200,
      height: 45,
      margin: EdgeInsets.only(bottom: 45),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white70)
        ),
        child: Text('ADICIONAR',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.white
          ),
        ),
        color: Colors.black54,
        onPressed: () {
          _validacao();
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _backBtn(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.only(left: 40, top: 100),
      child: RaisedButton(
        color: Colors.white70,
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _title() { //TITULO ACIMA DOS CAMPOS
    return Container(
        height: 405,
        width: 510,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Text(
          "Configuração",
          textAlign: TextAlign.center,

          style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 25,
              color: Colors.white70),
        )
    );
  }

  Widget _content() {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
          children: <Widget>[
            Padding( //ID
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'ID',
                ),
                controller: _idController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding( //OFFSET
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'Offset',
                ),
                controller: _offsetController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding( //HORA
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.grey, width: 0.8),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: //posição da escrita dentro do campo
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  //preenchivel
                  fillColor: Colors.white70,
                  //na cor branca
                  alignLabelWithHint: true,
                  //alinha o que ta dentro
                  hintText: 'Hora (HH:MM)',
                ),
                controller: _horaController,
                keyboardType: TextInputType.text,
              ),
            ),
          ]
      ),
    );
  }
}