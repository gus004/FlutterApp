import 'package:flutter/material.dart';
import 'package:flutterapp/pages/cadastro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/home.dart';
class Login extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Container(
          //padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fundo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child:
                Image.asset(
                    "assets/images/logo.png"
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child:
                TextField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                    filled: true,
                    fillColor: Colors.white,

                    alignLabelWithHint: true,
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child:
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,

                    alignLabelWithHint: true,
                    labelText: 'Senha',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child:
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 135,
                      child:
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)
                        ),
                        child:
                        Text(
                          'CADASTRE-SE',
                          style: TextStyle(
                              fontFamily: 'DoHyeon',
                              color: Colors.white
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: ()
                        {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Cadastro()
                              )
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 135,
                      child:
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)
                        ),
                        child:
                        Text(
                          'ENTRAR',
                          style: TextStyle(
                              fontFamily: 'DoHyeon',
                              color: Colors.white
                          ),
                        ),
                        onPressed: ()
                        {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                                  (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              OutlineButton(
                child: Text('Esqueci a senha',
                  style: TextStyle(
                    fontFamily: 'DoHyeon',
                  ),
                ),
                color: Colors.blue,
                onPressed: () {/** */},
              ),
              Expanded(
                child:
                Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 10),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Container(
                      child: Text(
                        "TESTE",
                        textAlign: TextAlign.right,

                        style: TextStyle(
                          fontFamily: 'DoHyeon',
                          fontSize: 20,
                          color: Colors.black45.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}