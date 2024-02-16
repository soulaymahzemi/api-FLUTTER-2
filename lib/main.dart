import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/todos.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// Future<Album> => te5ou un peu de temps pour le processeur
Future<List<todos>> fetchAlbum() async {
  //reponse du html contenant les données json
  var response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  //convert json to map
  var list = jsonDecode(response.body)as List;
  //convert json to map
  List<todos> todos1= list.map((e)=>todos.fromJson(e)).toList();

  return todos1;
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const DisplayDataAPI(),
    );
  }
}

class DisplayDataAPI extends StatefulWidget {
  const DisplayDataAPI();

  @override
  State<DisplayDataAPI> createState() => _DisplayDataAPIState();
}

class _DisplayDataAPIState extends State<DisplayDataAPI> {
  late Future<List<todos>> futurealbums;

  @override
  void initState() {
  
    super.initState();

    futurealbums = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DisplayDataAPI'),
      ),
      body: FutureBuilder<List<todos>>(
          future: futurealbums, //elli chye5dhou ml init state
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                
                
                itemBuilder: (context, index) =>Text('${snapshot.data![index].title}') );
            }
            if (snapshot.hasError) {
              Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}