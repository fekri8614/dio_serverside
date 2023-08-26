import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({super.key});

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  var jsonList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://protocoderspoint.com/jsondata/superheros.json');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data['superheros'] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('ERROR ==> $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes :-)'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.network(
                  jsonList[index]['url'],
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
              ),
              title: Text(jsonList[index]['name']),
              subtitle: Text(jsonList[index]['power']),
            ),
          );
        },
        itemCount: jsonList == null ? 0 : jsonList.length,
      ),
    );
  }
}
