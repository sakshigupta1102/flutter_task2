import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://official-joke-api.appspot.com/random_ten"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["id  "]);
    print(data[1]["type "]);
    print(data[1]["setup "]);

    print(data[1]["punchline"]);

    return "Success!";
  }


  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("RANDOM JOKES APP"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(


            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[

                Expanded(
                    child: Text("${data[index]["id"]} ${data[index]["type"]} ${data[index]["setup"]} ${data[index]["punchline"]}",

                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}