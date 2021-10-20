import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import '../controllers/registerController.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
                      "Créer votre compte privé!",
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
                          child: Text("S'enregistrer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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


      createUser(username: usernameState, email: emailState, password: passwordState, name: usernameState, adress: addressState)
          .then((value) => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Succès! Veillez maintenant vous connectez!")),
            ),
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Login(title: widget.title, ))
            )
          })
          .catchError((onError) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Une erreur s'est produite! Veillez réssayer.!")),
          ));
      /*****************************************************************/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
      setState(() {
        usernameState = usernameController.text = "";
        passwordState = passwordController.text = "";
        addressState = addressController.text = "";
        emailState = emailController.text = "";
      });
    }
  }

  //*************************************************************//
  //******************** Requetes vers l'api ********************//
  //*************************************************************//
  Future createUser({ username, password, adress, name, email }) async {
    final http.Response response = await http.post(
      Uri.parse("https://testappapi2021.herokuapp.com/api/user/store"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "name": name,
        "adress": adress,
        "email": email
      }),
    );

// Dispatch action depending upon
// the server response
    if (response.statusCode == 200) {
     //urn User.fromJson(json.decode(response.body));
    } else {
      //throw Exception('User loading failed!');
    }
  }
}
