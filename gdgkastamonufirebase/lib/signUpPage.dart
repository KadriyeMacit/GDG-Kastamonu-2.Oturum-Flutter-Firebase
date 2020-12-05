import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdgkastamonufirebase/loginPage.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  final kayitEmailController = TextEditingController();
  final kayitParolaController = TextEditingController();
  final isimController = TextEditingController();
  final parolaTekrarController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.deepOrangeAccent,
                  Colors.indigoAccent
                ])
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).size.height*0.1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Material(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all
                          (Radius.circular(10)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: isimController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Kadriye",
                            suffixText: "Kullanıcı adı"
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Material(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all
                          (Radius.circular(10)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: kayitEmailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "kadriye@gmail.com",
                            suffixText: "Kullanıcı email"
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Material(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all
                          (Radius.circular(10)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        obscureText: false,
                        controller: kayitParolaController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "****",
                            suffixText: "Parola"
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Material(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all
                          (Radius.circular(10)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        obscureText: false,
                        controller: parolaTekrarController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "****",
                            suffixText: "Parola tekrar"
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),


                  Material(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom:10,
                              left: 40,
                              right: 40),
                          child: InkWell(
                              child: Text("Kayıt ol!",
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              onTap : (){

                                if(isimController.text.trim().isNotEmpty &&
                                    kayitEmailController.text.trim().isNotEmpty &&
                                    parolaTekrarController.text.trim().isNotEmpty &&
                                    kayitParolaController.text.trim().isNotEmpty
                                )
                                {
                                  if(parolaTekrarController.text.trim() == kayitParolaController.text.trim())
                                  {
                                    _auth.createUserWithEmailAndPassword(email: kayitEmailController.text,
                                        password: kayitParolaController.text)
                                        .catchError((hata) => debugPrint("Hata: " + hata.toString()));

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  }
                                  else{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context)
                                        {
                                          return AlertDialog(
                                            title: Text("Kayıt oluşturulamadı"),
                                            content: Text("Parolalar eşleşmiyor"),
                                            actions: <Widget>[
                                              FlatButton(onPressed: (){
                                                Navigator.pop(context);
                                              }
                                                  , child: Text("Kapat"))
                                            ],
                                          );
                                        }
                                    );
                                  }


                                }

                                else{
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context)
                                      {
                                        return AlertDialog(
                                          title: Text("Kayıt oluşturulamadı"),
                                          content: Text("Boş alan bırakmayınız"),
                                          actions: <Widget>[
                                            FlatButton(onPressed: (){
                                              Navigator.pop(context);
                                            }
                                                , child: Text("Kapat"))
                                          ],
                                        );
                                      }
                                  );
                                }


                              })
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }



}
