import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Enterprises extends StatefulWidget {
  final List enterprises;
  final Map userdata;
  Enterprises({Key? key, required this.enterprises, required this.userdata }) : super(key: key);

  @override
  State<Enterprises> createState() => _EnterprisesState();
}

class _EnterprisesState extends State<Enterprises> {

  final nameController = TextEditingController();
  final numCfeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late List enterprises = [];
  late final fetchenterprises;
  late List formdata;
  late List formdata2;

  @override
  initState(){
    super.initState();
    fetchenterprises = fetchEnterprises();
    formdata = widget.enterprises;
  }

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

    return Container(
        child: Container(
            width: double.infinity,

            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Padding(
                      padding: EdgeInsets.only(left: 18, bottom: 8, right: 17),
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title: Text("Nouvelle entreprise"),
                                    content:Form(
                                      key: _formKey,
                                      child: Container(
                                        height: 200,
                                        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 12.0),
                                              decoration: const BoxDecoration(
                                                //border: Border(bottom: BorderSide(color: Colors.grey))
                                              ),
                                              child: Material(
                                                elevation: 2,
                                                child: _textFormModel(
                                                    labelText: "Nom de l'entreprise",
                                                    controller: nameController,
                                                    isEmptyValue: "Veillez entrez un nom valide!",
                                                    obscureText: false,
                                                    lengthVal: 'Nom de l\'entreprise ',
                                                    length: 3
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 12.0),
                                              decoration: const BoxDecoration(
                                                //border: Border(bottom: BorderSide(color: Colors.grey))
                                              ),
                                              child: Material(
                                                elevation: 2,
                                                child: _textFormModel(
                                                    labelText: 'Numero CFE',
                                                    controller: numCfeController,
                                                    isEmptyValue: 'Veillez entrez un Numero CFE valide!',
                                                    obscureText: false,
                                                    lengthVal: 'Numero CFE',
                                                    length: 3
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        textColor: Color(0xFF6200EE),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('FERMER'),
                                      ),
                                      FlatButton(
                                        textColor: Color(0xFF6200EE),
                                        onPressed: () => {
                                          submitData(widget.userdata['id'])
                                        },
                                        child: Text('VALIDER'),
                                      )
                                    ],
                                  )
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                                "Posts enregistés",
                                style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.w500)
                            ),
                            Spacer(),
                            Icon(Icons.add_circle_outline, color: Color.fromRGBO(143, 148, 251, .8),),
                            SizedBox(width: 3,),
                            Text(
                                "Entreprises enregistées",
                                style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      )
                  ),
                  ListView.separated(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount:  formdata.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return formdata.length==0
                            ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9378FF))),)
                            : Container(
                          height: 70,
                          margin: EdgeInsets.only(bottom: 3, left: 4, right: 4),
                          padding: EdgeInsets.only(bottom: 0, left: 25, right: 25, top: 0),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(143, 148, 251, .2),
                                child: Text(
                                  formdata[index]['enterprise_name'][0].toString().toUpperCase(),
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                                ),
                                radius: 25,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: queryData.size.height/38, left:10 ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          formdata[index]['enterprise_name'].toString(),
                                          style: const TextStyle(color: Colors.black54,fontSize: 19, fontWeight: FontWeight.w600)
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                          formdata[index]['num_cfe'].toString(),
                                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)
                                      ),
                                    ],
                                  )
                              ),
                              Spacer(),
                              InkWell(
                                child: Icon(Icons.delete_outline_rounded, color: Colors.red,),
                                onTap: (){
                                  _deleteDialog(context,formdata[index]['id'] ,formdata[index]['enterprise_name'].toString() );
                                },
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ]
            )
        )
    );
  }


  var nameState = '';
  var numCfeState = '';
  submitData(id) {
    setState(() {
      nameState = nameController.text;
      numCfeState = numCfeController.text;
    });
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.transparent, content: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(
            0xFFFFFFFF))),)),
      );

      createInterprise(enterprise_name: nameState, num_cfe: numCfeState, user_id: id )
          .then((value) => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Succès!")),
            ),
        fetchEnterprises(),
          })
          .catchError((onError) => print(onError.toString()));

    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
      setState(() {
        nameState = nameController.text = "";
        numCfeState = numCfeController.text = "";
      });
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

  void _deleteDialog(BuildContext context, data_id, data_name) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Supprimer: "+data_name+"  ?"),
          content: Text(""),
          actions: [
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () => {
                Navigator.pop(context),
              },
              child: Text('NON'),
            ),
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () =>
              {
                Navigator.pop(context),
                SnackBar(
                    backgroundColor: Colors.transparent,
                    content: Center(
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(
                          0xFFFFFFFF))),
                    )
                ),
                deleteInterprise(id: data_id)
                    .then((r)=>{
                      fetchEnterprises(),
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Une erreur s'est produite! Veillez réssayer.!")),
                      )
                    })
                    .catchError((onError)=> {
                      print(onError.toString())
                    }),
              },
              child: Text('OUI'),
            )
          ],
        )
    );
  }

  //*************************************************************//
  //******************** Requetes vers l'api ********************//
  //*************************************************************//

  Future fetchEnterprises() async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/enterprise/getAllEnterprises/'+widget.userdata['id'].toString()));
    print(response);
    if (response.statusCode == 200) {
      formdata2 = json.decode(response.body);
      setState(() {
        formdata2 = json.decode(response.body);
        formdata = formdata2;
      });
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Erreur');
    }
  }

  Future deleteInterprise({ id }) async {
    final http.Response response = await http.post(
      Uri.parse("https://testappapi2021.herokuapp.com/api/enterprise/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id.toString()
      }),
    );
  }
}



