import 'package:flutter/material.dart';
import 'package:flutterapp/model/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Firestore db = Firestore.instance;

  _body() {
    return StreamBuilder(
        stream: db.collection("animais").snapshots(),
// ignore: missing_return
        builder: (context, snapshot) {
          switch( snapshot.connectionState ) {
            case ConnectionState.none :
            case ConnectionState.done :

            case ConnectionState.waiting :
              print("WAINTING");
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando animais..."),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;

            case ConnectionState.active :
              QuerySnapshot querySnapshot = snapshot.data;

              if(snapshot.hasError) {
                return Container(
                  child: Text("Ocorreram erros ao carregar os dados!"),
                );
              }
              else {
                print("DADOS CARREGADOS: "+snapshot.data.toString());

                return Container(
                    child: ListView.builder(
                        itemCount: querySnapshot.documents.length,
                        itemBuilder: (context, index) {
                          //recupera os animais
                          List<DocumentSnapshot> animais = querySnapshot.documents.toList();
                          DocumentSnapshot dados = animais[index];

                          Animal animal = Animal(dados["nome"], dados["idade"], dados["raca"], dados["foto"]);

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(animal.foto),
                            ),
                            title: Text( animal.nome ),
                            subtitle: Text( animal.raca + ", " + animal.idade + " anos."),
                          );
                        }
                    )
                );
              }
              break;
          }

        }

    );



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seus pets"),
          centerTitle: true,
        ),
        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.add), onPressed: null),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.pets,
                      color: Colors.blue,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.people,
                      color: Colors.blue,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    onPressed: null),
              ],
            ),
          ),
        ),
        body: _body()
    );
  }
}


