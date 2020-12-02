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

      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

              RaisedButton(
                child: Text("Giriş yap"),
                  onPressed: (){

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
              }),


              SizedBox(height: 20,),

              InkWell(
                child: Text("Kayıt ol",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        )),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SignUpPage()
                  ));
                },
              ),

              RaisedButton(onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));

              })

            ],
          ),
      ),

    );
  }
}
