import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YemekSayfasi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FoodPage();
  }
}

class FoodPage extends State<YemekSayfasi> {

  File imageFile;

  String id;
  final db = Firestore.instance;
  final _formKey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  String name, location, notes;

  var url;

  _openGallery(BuildContext context) async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() //arayüze de yansıması için setState
    {
      imageFile = resim;
    });

    Navigator.pop(context);

  }

  _openCamera(BuildContext context) async {
    var resim = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = resim;
    });

    Navigator.pop(context);

  }

  Future<void> _showChoiseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Görsel eklemek için seçin!",
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: Container(
                height: MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_size_select_actual,
                        color: Color(0xFFFc6076), size: 60),
                    title: Text(
                      'Galeri',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera,
                        color: Color(0xFFFc6076), size: 60),
                    title: Text(
                      'Kamera',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ]),
              ));
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Material(
          child: Container(
            height: MediaQuery.of(context).size.height*0.19,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("images/holiday.jpg"),
          ));
    } else {
      return ResimSecince();
    }
  }

  Widget ResimSecince() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.file(
            imageFile,
            height: MediaQuery.of(context).size.height*0.19,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }

  TextFormField locationTextFormField() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          //dışını kutu içine alır
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: 'Gezilen yerin nerde olduğunu yazabilirsiniz',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Lütfen bir şey yazın';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  TextFormField malzemelerForm() {
    return TextFormField(
      maxLines: 2,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: 'Gezi hakkında herhangi bir bilgi yazabilirsiniz',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Lütfen bir şey yazın';
        }
      },
      onSaved: (value) => location = value,
    );
  }

  TextFormField yapilisForm() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: 'Geziden bulunan kişileri yazabilirsiniz',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Lütfen bir şey yazın';
        }
      },
      onSaved: (value) => notes = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: Scaffold(

        floatingActionButton: FloatingActionButton(
            onPressed: createData,
          child: Icon(Icons.done_outlined),
          backgroundColor: Colors.transparent,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.04),
            child: Column(

              children: [

                Text(
                    "Yeni gezi ekle!",
                  style: TextStyle(
                       fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              Text(
                                "Konum",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFFc6076),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.not_listed_location)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Form(
                            key: _formKey,
                            child: locationTextFormField(),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              Text(
                                "Notlar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFFc6076),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.create_sharp)
                            ],
                          )
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Form(
                            key: _formKey2,
                            child: malzemelerForm(),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              Text(
                                "Kişiler",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFFc6076),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.person)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Form(
                            key: _formKey3,
                            child: yapilisForm(),
                          ),
                        ),

                        SizedBox(height: 10,),

                        GestureDetector(
                          onTap: () {
                            _showChoiseDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Görsel ekle",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Icon(Icons.photo)
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        _decideImageView(),

                      ],
                    ),

                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }

  void createData() async {

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("user")
        .child("kadriye")
        .child("$_formKey");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("upload edilen resmin urlsi : " + url);


    if (_formKey.currentState.validate() &&
        _formKey2.currentState.validate() &&
        _formKey3.currentState.validate()) {
      _formKey.currentState.save();
      _formKey2.currentState.save();
      _formKey3.currentState.save();
      DocumentReference ref = await db.collection('post').add({
        'name': '$name',
        'location': "$location",
        'notes': "$notes",
        'image': "$url"
      });
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }

    Fluttertoast.showToast(
        msg: "Yeni gezi kaydedildi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );


  }
}