import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage> {

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xFF0EDED2), accentColor: Color(0xFFFc6076)),
    home: Scaffold(

        body: StreamBuilder(
          stream: Firestore.instance.collection("post").snapshots(),
          builder: (context, snaphot) {
            if (!snaphot.hasData) {
              return Text("Yükleniyor");
            }
            else
              {
              return ListView.builder(
                  itemCount: snaphot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data.documents[index];

                    Future<void> _showChoiseDialog(BuildContext context) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(
                                  "Silmek istediğinize emin misiniz?",
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8.0))),
                                content: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            var silenecek_veri = Firestore
                                                .instance
                                                .collection('post')
                                                .document(mypost.documentID)
                                                .delete();

                                            debugPrint("$silenecek_veri");

                                            debugPrint("Veri silindi!");

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Evet",
                                            style: TextStyle(
                                                color: Color(0xFF0EDED2),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Vazgeç",
                                            style: TextStyle(
                                                color: Color(0xFF0EDED2),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )));
                          });
                    }

                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 350.0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 14,
                                  shadowColor: Color(0x802196F3),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {

                                                  _showChoiseDialog(context);

                                                },
                                                child: Image.network(
                                                  "${mypost['image']}",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Nerde: ",
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Color(
                                                            0xFFFc6076)),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${mypost['name']}",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                      textAlign:
                                                      TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                            child: SingleChildScrollView(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Anılar: ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Color(0xFFFc6076)),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${mypost['location']}",
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Kimlerle: ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Color(0xFFFc6076)),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${mypost['notes']}",
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  );
            }
          },
        )),
  );
}
}