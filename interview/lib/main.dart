import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var getdata;
  apifunction() async {
    dynamic responseBody;
    responseBody = await http.get(Uri.parse(Api.apiurl));
    var response = jsonDecode(responseBody.body);
    print(response);
    print(response);
    print(response);
    setState(() {
      getdata = response;
    });
    return getdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          height: 500,
          width: 400,
          child: FutureBuilder(
            future: apifunction(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 4,
                    width: 400,
                    child: ListView.builder(
                      itemCount: 5,
                      //  getdata["items"][0]["owner"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CircleAvatar(
                                  //     radius: 60,
                                  //     backgroundImage: NetworkImage(
                                  //         "${getdata["items"][index]["owner"]["profile_image"]}"
                                  //             .toString())),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200,
                                            color: Colors.amber,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage: NetworkImage(
                                                        "${getdata["items"][index]["owner"]["profile_image"]}"),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                          "${getdata["items"][index]["owner"]["display_name"]}"))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "dfhfxghnfghfg",
                                      // "${getdata["items"][index]["owner"]["display_name"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[];
              }
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ));
  }
}
