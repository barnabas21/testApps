import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';

import 'package:testappmobile/widgets/bottomNavigationBar.dart';
import 'package:testappmobile/widgets/enterprises.dart';
import 'package:testappmobile/widgets/posts.dart';
import 'package:testappmobile/widgets/profile.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({Key? key, required this.title, required this.usernme, required this.userdata}) : super(key: key);
  final String title;
  final String usernme;
  final Map userdata;

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  int selectedIndex = 0;
  late List posts = [];
  late List enterprises = [];

  @override
  initState(){
    super.initState();
    fetchPosts();
    fetchEnterprises();
  }

  //*************************************************************//
  //******************** Requetes vers l'api ********************//
  //*************************************************************//
  Future fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/post/getAllPosts/'+widget.userdata['id'].toString()));
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fetchEnterprises() async {
    final response = await http
        .get(Uri.parse('https://testappapi2021.herokuapp.com/api/enterprise/getAllEnterprises/'+widget.userdata['id'].toString()));
    print(response);
    if (response.statusCode == 200) {
      enterprises = json.decode(response.body);
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(65.0),
            child: Container(
              color: Colors.white,
              child: AppBar(
                title: Container(
                  padding: EdgeInsets.only(top: 7, left: 7),
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      Text(widget.title),
                      Spacer(),
                      InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              widget.usernme.toString()[0].toUpperCase(),
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                            ),
                            radius: 23,
                          )
                      ),
                    ],
                  ),
                ),
                backgroundColor: const Color(0xFF6C63FF),
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: [
              Enterprises(userdata: widget.userdata, enterprises: enterprises),
              Posts(userdata: widget.userdata, posts: posts ),
              Profile(userdata: widget.userdata),
            ].elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomMenu(
            selectedIndex: selectedIndex,
            onClicked: onClicked,
          )
    );
  }
}
