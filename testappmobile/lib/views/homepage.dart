import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testappmobile/views/register.dart';
import 'package:testappmobile/views/registerEnterprise.dart';

import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return  Scaffold(
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: queryData.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: queryData.size.height/5,
                      child: SvgPicture.asset(
                          "assets/images/splash.svg",
                          semanticsLabel: 'Acme Logo'
                      )
                    ),
                    SizedBox(height: queryData.size.height/20,),
                    Text("TESTAPP", style: TextStyle(fontSize: 25, color: const Color(0xFF5B5B5B), fontWeight: FontWeight.w700)),
                    SizedBox(height: queryData.size.height/13,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, 1),
                              ]
                          )
                      ),
                      child: InkWell(
                        child: const Center(
                          child: Text("Créez un compte privé", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        onTap: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Register(title: widget.title,))
                          );
                        },
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10,),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .8),
                              ]
                          )
                      ),
                      child: InkWell(
                        child: const Center(
                          child: Text("Créez un compte professionnel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        onTap: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterEnterprise(title: widget.title,))
                          );
                        },
                      ),
                    ),
                    SizedBox(height: queryData.size.height/20,),
                    Row(
                        children: const <Widget>[
                          Expanded(
                              child: Divider()
                          ),
                          Text("OU"),
                          Expanded(
                              child: Divider()
                          ),
                        ]
                    ),
                    SizedBox(height: queryData.size.height/20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFF62B554)
                      ),
                      child: InkWell(
                        child: const Center(
                          child: Text("Connectez-vous!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        onTap: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Login(title: widget.title,))
                          );
                        },
                      )
                    ),
                  ]
              ),
            )
        )
    );
  }
}
