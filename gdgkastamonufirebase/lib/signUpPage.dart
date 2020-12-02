import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdgkastamonufirebase/loginPage.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final kayitEmailController = TextEditingController();
  final kayitParolaController = TextEditingController();
  final isimController = TextEditingController();
  final parolaTekrarController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Stack(
        children: [

          //geri butonu
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.055,
                left: MediaQuery.of(context).size.height*0.015,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                    width: 30,
                    child: Icon(Icons.arrow_back_ios_outlined)
                ),
              ),
            ),
          ),

          //--------------------------------------------------------------------------------------------------------

          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.3
            ),
            child: Column(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(right: 40, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, right: 20, top: 0, bottom: 0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Kadriye",
                              suffixText: "Kullanıcı adı",
                              hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                          controller:  isimController,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 40, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, right: 20, top: 0, bottom: 0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "kadriyemacit@gmail.com",
                              suffixText: "E-mail adresi",
                              hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                          controller: kayitEmailController,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 40, top: 0, bottom: 0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "*****",
                              prefixText: "Parola",
                              hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                          controller: kayitParolaController,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 40, top: 0, bottom: 0),
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "*****",
                              prefixText: "Parola Tekrar",
                              hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                          controller: parolaTekrarController,
                        ),
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 20,),

                InkWell(
                  child: Text("Kayıt ol",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  onTap: (){

                    if (isimController.text.trim().isNotEmpty &&
                        kayitEmailController.text.trim().isNotEmpty &&
                        kayitParolaController.text.trim().isNotEmpty &&
                        parolaTekrarController.text.trim().isNotEmpty) {

                      if (kayitParolaController.text
                          .trim()
                          == parolaTekrarController.text.trim())
                      {


                        _auth.createUserWithEmailAndPassword(
                            email: kayitEmailController.text,
                            password: kayitParolaController.text)
                            .catchError((hata) =>
                            debugPrint("HATA: " + hata.toString()));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));

                      }

                      else
                      {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Kayıt oluşturulamadı"),
                                content: Text("Parolalar eşleşmiyor"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Kapat"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }

                    }

                    else
                    {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Kayıt oluşturulamadı"),
                              content: Text("Boş alan bırakmayınız!"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Kapat"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }


                  },
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }
}
