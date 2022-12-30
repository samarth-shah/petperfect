import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../model/home_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box = Hive.box('storeData');
  var dio = Dio();
  bool gotData = false;
  List<HomeData>? homeData;

  Future<void> getHomeData() async {
    try {
      final response =
          await dio.get('http://jsonplaceholder.typicode.com/posts');
      final hData =
          (response.data as List).map((data) => HomeData.fromMap(data));
      homeData = hData.toList();
      setState(() {
        gotData = true;
      });
      // Fluttertoast.showToast(msg: box.get(0));
    } catch (e) {
      throw Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetPerfect'),
      ),
      body: Center(
        child: gotData
            ? ListView.builder(
                itemCount: homeData?.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(2),
                  child: ListTile(
                    title: Text(homeData![index].title),
                    subtitle: Text(homeData![index].body),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
