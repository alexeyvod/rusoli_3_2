import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кейс 3.2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Кейс 3.2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Post>? post;

  Future<Post> getPost() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200){
      return Post.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //post = getPost();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<Post>(
                  future: getPost(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
                    if (snapshot.data == null ) {
                      return const Center(child: CircularProgressIndicator());
                    } else{
                      return Column(
                        children: [
                          SizedBox(height: 10,),
                          Text(snapshot.data!.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.indigo,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)
                          ),
                          SizedBox(height: 10,),
                          Text(snapshot.data!.body,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.indigo,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)
                          ),
                        ],
                      );
                    }
                  }
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
