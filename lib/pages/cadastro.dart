import 'package:flutterapp/pages/home1.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _nomeController  = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  // state var
  String _erroMsg = "";

  _validacao() {
    String nome  = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (nome.isNotEmpty || email.isNotEmpty || senha.isNotEmpty) {
      if (!email.contains("@")) {
        setState(() {
          _erroMsg = "Informe um e-mail válido!";
        });
      }
      else if (!(senha.length > 6)) {
        setState(() {
          _erroMsg = "Senha deve ter mais de 6 caracteres!";
        });
      }
      else {
        setState(() {
          _erroMsg = "";
        });

        Usuario usuario = Usuario();
        usuario.nome = nome;
        usuario.email = email;
        usuario.senha = senha;

        _cadastrar(usuario);
      }
    }
    else {
      setState(() {
        _erroMsg = "Preencha todos os campos!";
      });
    }
  }

  _cadastrar(Usuario usuario) {

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {
      // Se usuário cadastrado, loga no sistema
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print("Erro retornado do Firebase: "+error.toString());
      setState(() {
        _erroMsg = "Erro ao cadastrar o usuário. Confirme os dados informados!";
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80, left: 80, right: 80),
                child:
                Image.asset(
                    "assets/images/logo.png"
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    hintText: 'Nome Completo',
                  ),
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    hintText: 'E-mail',
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    labelText: 'Senha',
                  ),
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Text(
                  _erroMsg,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 150,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        child: Text(
                          'CADASTRAR',
                          style:
                          TextStyle(fontFamily: 'Oswald', color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          _validacao();
                        },
                      ),
                    ),

                    Container(
                      width: 150,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)
                        ),
                        child: Text('VOLTAR',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.white
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ]
        ),
      ),
    );
  }
}