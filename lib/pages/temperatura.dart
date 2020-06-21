import 'package:flutter/material.dart';
import 'package:com/model/TemperaturaClass.dart';
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

                          TemperaturaClass temperatura = TemperaturaClass(dados["temp"]);

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
          backgroundColor: Colors.blue.withOpacity(0.3),
          title: Center(
            child: Text('TEMPERATURAS',
              style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
            ),
          ),
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
