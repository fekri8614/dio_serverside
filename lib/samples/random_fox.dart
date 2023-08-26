import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RandomFox extends StatefulWidget {
  const RandomFox({super.key});

  @override
  State<RandomFox> createState() => _RandomFoxState();
}

class _RandomFoxState extends State<RandomFox> {
  static const apiUrl = 'https://randomfox.ca/floof/?ref=apilist.fun';
  var foxImageUrl;

  @override
  void initState() {
    super.initState();
    getFoxData(); // get data
  }

  void getFoxData() async {
    try {
      var response = await Dio().get(apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          foxImageUrl = response.data['image'];
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('ERROR ==> $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Fox Images'),
      ),
      body: Center(
        child: Container(
          child: Image.network(
            foxImageUrl,
            width: 300,
            height: 400,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getFoxData();
        },
        child: const Icon(Icons.replay),
      ),
    );
  }
}
