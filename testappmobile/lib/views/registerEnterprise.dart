import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testappmobile/views/registerEnterprise2.dart';

import 'login.dart';
import '../controllers/RegisterController.dart';

class RegisterEnterprise extends StatefulWidget {
  const RegisterEnterprise({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterEnterprise> createState() => _RegisterEnterpriseState();
}

class _RegisterEnterpriseState extends State<RegisterEnterprise> {

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  Widget _textFormModel ({labelText, controller, isEmptyValue, obscureText: false, lengthVal, length}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 8, bottom: 2, top: 2),
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
              height: 230,
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
                        child: Text("Inscription", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 25, right: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Créer votre compte pro!",
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: queryData.size.height/50,),
                    Container(
                      padding: const EdgeInsets.all(5),
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
                                  labelText: "Email",
                                  controller: emailController,
                                  isEmptyValue: "Veillez entrez Email valide!",
                                  obscureText: false,
                                  lengthVal: 'Email',
                                  length: 6
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
                                  labelText: "Mot de passe",
                                  controller: passwordController,
                                  isEmptyValue: "Veillez entrez un Mot de passe valide!",
                                  obscureText: false,
                                  lengthVal: 'Mot de passe',
                                  length: 4
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            decoration: const BoxDecoration(
                              //border: Border(bottom: BorderSide(color: Colors.grey))
                            ),
                            child: Material(
                              elevation: 2,
                              child: _textFormModel(
                                  labelText: "Adresse",
                                  controller: addressController,
                                  isEmptyValue: "Veillez entrez une Adresse valide!",
                                  obscureText: false,
                                  lengthVal: 'Adresse ',
                                  length: 4
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18,),
                    InkWell(
                      onTap: (){
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
                        child: const Center(
                          child: Text("Suivant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Login(title: widget.title,))
                        );
                      },
                      child: const Text("Connectez-vous!", style: TextStyle(color: Color(0xFF6C63FF)),),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  var usernameState = '';
  var passwordState = '';
  var emailState = '';
  var addressState = '';

  //Soumettre le formulaier
  submitFunction() async {
    setState(() {
      usernameState = usernameController.text;
      passwordState = passwordController.text;
      addressState = addressController.text;
      emailState = emailController.text;
    });

    if (_formKey.currentState!.validate()) {
      print("user : "+this.usernameState);
      print("pwd : "+this.passwordState);

      Map data = {
        "username": usernameState,
        "password": passwordState,
        "name": usernameState,
        "adress": addressState,
        "email": emailState
      };

      print(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Succès! Veillez maintenant enregisgitr votre 1ère entreprise!")),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => RegisterEnterprise2(title: widget.title, firstData: data ))
      );

      /*****************************************************************/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
    }
  }
}
