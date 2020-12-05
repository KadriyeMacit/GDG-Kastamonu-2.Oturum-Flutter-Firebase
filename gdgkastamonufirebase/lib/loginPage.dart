import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdgkastamonufirebase/homePage.dart';
import 'package:gdgkastamonufirebase/signUpPage.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Container(
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
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height*0.2,
            bottom: MediaQuery.of(context).size.height*0.2,
            left: MediaQuery.of(context).size.width*0.1,
            right: MediaQuery.of(context).size.width*0.1,
          ),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      'Gezi Rehberine Hoş Geldiniz!',
                    ),

                    SizedBox(height: 30,),

                    Container(
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, right: 20, top: 0, bottom: 0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı adı",
                                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                            controller: emailController,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, right: 20, top: 0, bottom: 0),
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Parola",
                                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                            controller: passwordController,
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
                            onTap: (){

                              _auth.signInWithEmailAndPassword
                                (email: emailController.text
                                  , password: passwordController.text)
                                  .then((oturumAcildi){
                                // then() ile giriş işlemi yapıldıktan sonra sayfa geçişini sağlıyoruz
                                debugPrint("Giriş başarılı");

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage()
                                ));
                              })
                                  .catchError((hata) => debugPrint("Hata: "+ hata.toString()));
                            },

                            child: Text("Giriş yap",
                              style: TextStyle(
                                  color: Colors.white
                              ),),

                          ),
                        )

                    ),


                    SizedBox(height: 20,),

                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      height: 0.2,
                      color: Colors.black,
                    ),

                    SizedBox(height: 20,),

                    InkWell(
                      child: Text("Üye değilseniz, Kayıt olun!",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => RegisterPage()
                        ));
                      },
                    ),

                  ],
                ),
              )
          ),
        ),
      ),

    );
  }
}
