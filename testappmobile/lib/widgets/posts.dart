import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Posts extends StatefulWidget {
  final Map userdata;
  final List posts;
  const Posts({Key? key, required this.userdata, required this.posts}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late List posts = [];
  late final fetchposts;
  late List formdata;
  late List formdata2;

  @override
  initState(){
    super.initState();
    fetchposts = fetchPosts();
    formdata = widget.posts;
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

    return Center(
        child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 10),
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        //letterSpacing: 1
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        hintText: "Entrez le titre de l'article recherché ici..",
                        focusColor: Color(0xFF9378FF),
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 30),
                    height: 42.5,
                    width: queryData.size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .8),
                            ]
                        )
                    ),
                    child: InkWell(
                      child: const Center(
                        child: Text("Rechercher", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 2),
                    child: const Text(
                        "",
                        style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 18, bottom: 8, right: 17),
                      child: InkWell(
                        onTap: (){
                          print("ssdg");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title: Text("Nouvel article"),
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
                                                    labelText: "Objet",
                                                    controller: titleController,
                                                    isEmptyValue: "Veillez entrez un objet valide!",
                                                    obscureText: false,
                                                    lengthVal: 'Objet du message ',
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
                                                    labelText: 'Votre message, Pas plus de 200 caractères',
                                                    controller: messageController,
                                                    isEmptyValue: 'Veillez entrez un votre message valide!',
                                                    obscureText: false,
                                                    lengthVal: 'Votre message',
                                                    length: 15
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
                                "Ajouter un post ",
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
                          height: 100,
                          margin: EdgeInsets.only(bottom: 3, left: 4, right: 4),
                          padding: EdgeInsets.only(bottom: 0, left: 20, right: 25, top: 0),
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
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                              formdata[index]['title'].toString(),
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                            ),
                                            content: Container(
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
                                                    child: Expanded(
                                                      child: Text(
                                                        formdata[index]['title'].toString(),
                                                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                                                      )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              FlatButton(
                                                textColor: Color(0xFF6200EE),
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Fermer'),
                                              )
                                            ],
                                          )
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color.fromRGBO(143, 148, 251, .2),
                                  child: Text(
                                    formdata[index]['title'][0].toString().toUpperCase(),
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                                  ),
                                  radius: 30,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                              formdata[index]['title'].toString(),
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                            ),
                                            content: Container(
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
                                                    child: Expanded(
                                                        child: Text(
                                                          formdata[index]['title'].toString(),
                                                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              FlatButton(
                                                textColor: Color(0xFF6200EE),
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Fermer'),
                                              )
                                            ],
                                          )
                                  );
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(top: queryData.size.height/38, left:10 ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            formdata[index]['title'].toString(),
                                            style: TextStyle(color: Colors.black54,fontSize: 19, fontWeight: FontWeight.w600)
                                        ),
                                        SizedBox(height: 3,),
                                        SizedBox(
                                          width: queryData.size.width*4.5/9,
                                          child: Text(
                                            formdata[index]['message'].toString(),
                                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                child: Icon(Icons.delete_outline_rounded, color: Colors.red,),
                                onTap: (){
                                  _deleteDialog(context, formdata[index]['id'] ,formdata[index]['title'].toString() );
                                },
                              )

                            ],
                          ),
                        );
                      }
                  )
                ]
            )
        )
    );
  }

  var titleState = '';
  var messageState = '';
  submitData(id) {
    setState(() {
      titleState = titleController.text;
      messageState = messageController.text;
    });
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.transparent, content: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(
            0xFFFFFFFF))),)),
      );

      createPost(title: titleState, message: messageState, user_id: id )
          .then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Succès!")),
        ),
        setState(() {
          titleState = titleController.text = "";
          messageState = messageController.text = "";
        }),
        fetchPosts(),
      })
          .catchError((onError) => print(onError.toString()));

    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veillez entrez des données correctes!")),
      );
      setState(() {
        titleState = titleController.text = "";
        messageState = messageController.text = "";
      });
    }
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
                deletePost(id: data_id)
                    .then((r)=>{
                  setState(() {
                    titleState = titleController.text = "";
                    messageState = messageController.text = "";
                  }),
                  fetchPosts(),
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

  Future createPost({ title, message, user_id }) async {
    final http.Response response = await http.post(
      Uri.parse("https://testappapi2021.herokuapp.com/api/post/store"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "title": title,
        "message": message,
        "user_id": user_id.toString()
      }),
    );
  }

  Future fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/post/getAllPosts/'+widget.userdata['id'].toString()));
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

  Future deletePost({ id }) async {
    final http.Response response = await http.post(
      Uri.parse("https://testappapi2021.herokuapp.com/api/post/delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id.toString()
      }),
    );
  }



}
