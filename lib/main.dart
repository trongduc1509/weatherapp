import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main(List<String> args) async {
  final response = await get(Uri.parse(
      'http://api.weatherapi.com/v1/forecast.json?key=e32c5fceb05b432a80551045221007&q=Paris'));
  final converted = jsonDecode(response.body);
  print(converted.runtimeType);
  print(converted['current']['condition']['icon']);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TronD Weather App'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
