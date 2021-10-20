
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import '../controllers/RegisterController.dart';

class RegisterEnterprise2 extends StatefulWidget {
  const RegisterEnterprise2({Key? key, required this.title, required this.firstData}) : super(key: key);
  final String title;
  final Map firstData;

  @override
  State<RegisterEnterprise2> createState() => _RegisterEnterprise2State();
}

class _RegisterEnterprise2State extends State<RegisterEnterprise2> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numCfeController = TextEditingController();

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
                                  labelText: "Le Nom de votre entreprise",
                                  controller: nameController,
                                  isEmptyValue: "Veillez entrez Nom valide!",
                                  obscureText: false,
                                  lengthVal: 'Nom de votre entreprise ',
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
                                  labelText: "Numero CFE",
                                  controller: numCfeController,
                                  isEmptyValue: "Veillez entrez Numero CFE valide!",
                                  obscureText: false,
                                  lengthVal: 'Numero CFE',
                                  length: 6
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
  var nameState = '';
  var numCfeState = '';

  //Soumettre les 2 formulaires
  submitFunction() async {
    setState(() {
      nameState = nameController.text;
      numCfeState = numCfeController.text;
    });

    if (_formKey.currentState!.validate()) {
      print("user : "+this.nameState);
      print("pwd : "+this.numCfeState);

      //Créer l'utilisateur via le miodele de page precedente
      await createUser(
          username: widget.firstData['username'],
          email: widget.firstData['email'],
          password: widget.firstData['username'],
          name: widget.firstData['username'],
          adress: widget.firstData['adress']
      ).then((value) async => {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veillez patientez une petite seconde!")),
        ),

        //Rechercher l'utilisateur crée pour ajouter une nouvelle entreprise à son compte
      await fetchUser(widget.firstData['username'])
          .then((value) => {

        //Ajout de l'entreprise
      createInterprise(enterprise_name: nameState, num_cfe: numCfeState, user_id: value[0]['id'] )
          .then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Connectez-vous dès à présent!")),
        ),
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Login(title: widget.title, ))
        )
      }).catchError((onError) => print(onError.toString()))
      })

      }).catchError((onError) =>
      {ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Une erreur s'est produite! Veillez réssayer.!")),
      ),
      });
      /*****************************************************************/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
      setState(() {
        nameState = nameController.text = "";
        numCfeState = numCfeController.text = "";
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
  }

  Future fetchUser(String username) async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/user/get/'+username));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur');
    }
  }

  Future createInterprise({ enterprise_name, num_cfe, user_id }) async {
    final http.Response response = await http.post(
      Uri.parse("https://testappapi2021.herokuapp.com/api/enterprise/store"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "enterprise_name": enterprise_name,
        "num_cfe": num_cfe,
        "user_id": user_id.toString()
      }),
    );
  }


}
