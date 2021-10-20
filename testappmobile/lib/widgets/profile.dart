import 'package:flutter/material.dart';

import 'package:testappmobile/views/login.dart';
import 'package:testappmobile/views/registerEnterprise.dart';

class Profile extends StatelessWidget {
  Map userdata;
  Profile({Key? key, required this.userdata }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    print(userdata['name'].toString());
    return Center(
        child: Container(
            width: double.infinity,
            height: queryData.size.height*4/5,

            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    height: 160,
                    padding: EdgeInsets.only(bottom: 20),
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(143, 148, 251, .2),
                      child: Text(
                        userdata['username'].toString()[0].toUpperCase(),
                        style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300),),
                      radius: 60,
                    )
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
                      padding: EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nom d'utilisateur", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Text(userdata['username'].toString(), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      )
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
                      padding: EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                      decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Mot de passe", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Text(userdata['password'].toString(), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      )
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
                      padding: EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                      decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Text(userdata['email'].toString(), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      )
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
                      padding: EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                      decoration:  BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Adresse", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Text(userdata['adress'].toString(), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30,),
                    height: 42.5,
                    width: queryData.size.width*4/9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFFF84F4F),
                              Color(0xFFFC7D7D),
                            ]
                        )
                    ),
                    child: InkWell(
                      child: const Center(
                        child: Text("Déconnexion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Login(title: "TESTAPP",))
                        );
                      },
                    ),
                  ),
                ]
            )
        )
    );
  }


}
