import 'package:flutter/material.dart';
import 'package:com/model/Temperatura.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Temperatura extends StatefulWidget {
  @override
  _TemperaturaState createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  Firestore db = Firestore.instance;

  _body() {
    return StreamBuilder(
        stream: db.collection("temperaturas").snapshots(),
// ignore: missing_return
        builder: (context, snapshot) {
          switch( snapshot.connectionState ) {
            case ConnectionState.none :
            case ConnectionState.done :

            case ConnectionState.waiting :
              print("WAITING");
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando temperaturas..."),
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
                          //recupera as temperaturas
                          List<DocumentSnapshot> temperaturas = querySnapshot.documents.toList();
                          DocumentSnapshot dados = temperaturas[index];

                          Temperatura temperatura = Temperatura(dados["temp"]);

                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(temperatura.temp),
                                ),
                              ],
                            ),
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
