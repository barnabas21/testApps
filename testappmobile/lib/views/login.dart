import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:testappmobile/views/homepage.dart';
import 'package:testappmobile/views/profileIndex.dart';
import 'package:testappmobile/views/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _textFormModel ({labelText, controller, isEmptyValue, obscureText: false, lengthVal, length}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 8, bottom: 5, top: 5),
      child: TextFormField(
        cursorColor: Colors.grey,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 15.0,
          color: Colors.black,
          //letterSpacing: 1
        ),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          focusColor: Color(0xFF9378FF),
          labelStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return isEmptyValue;
          }
          if (value.length < length) {
            return 'Le nombre de caractères entrés ne doit pas être inférieur '+ length.toString();
          }

          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background0.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(top: 0, bottom: 20),
                      child: const Center(
                        child: Text("Connexion", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text("Veillez vous connectez pour continuer!", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),),
                    SizedBox(height: queryData.size.height/50,),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 8.0),
                            decoration: const BoxDecoration(
                              //border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Material(
                              elevation: 2,
                              child: _textFormModel(
                                  labelText: "Nom d'utilisateur",
                                  controller: usernameController,
                                  isEmptyValue: "Veillez entrez un numero de Nom d'utilisateur valide!",
                                  obscureText: false,
                                  lengthVal: 'pseudo ',
                                  length: 3
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 8.0),
                            decoration: const BoxDecoration(
                              //border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Material(
                              elevation: 2,
                              child: _textFormModel(
                                  labelText: 'Mot de passe',
                                  controller: passwordController,
                                  isEmptyValue: 'Veillez entrez un Mot de passe valide!',
                                  obscureText: true,
                                  lengthVal: 'Mot de passe ',
                                  length: 3
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        print("taped");

                        //fetchUser();
                        submitFunction();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ]
                            )
                        ),
                        child: Center(
                          child: Text("Connexion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => MyHomePage(title: widget.title,))
                        );
                      },
                      child: const Text("S'Inscrire", style: TextStyle(color: Color(0xFF6C63FF)),),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  var usernameState = '';
  var passwordState = '';

  //Soumettre le formulaire
  submitFunction() async {
    setState(() {
      usernameState = usernameController.text;
      passwordState = passwordController.text;
    });


    //print(res);
    if (_formKey.currentState!.validate()) {
      print("user : "+usernameState);
      print("pwd : "+passwordState);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.transparent, content: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(
            0xFFFFFFFF))),)),
      );
        await fetchUser(usernameState).then((value) => {

          if(value[0]['username'] == usernameState && value[0]['password'] == passwordState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Succès! Vous êtes maintenant connectés!")),
            ),
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ProfileIndex(title: widget.title, usernme: value[0]['username'], userdata: value[0] ))
            )
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Attention! Mot de passe ou nom d'utilisateur erroné!")),
            )
          }
        });
      /*****************************************************************/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
      setState(() {
        usernameState = usernameController.text = "";
        passwordState = passwordController.text = "";
      });
    }
  }


  //*************************************************************//
  //******************** Requetes vers l'api ********************//
  //*************************************************************//

  Future fetchUser(String username) async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/user/get/'+username));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
