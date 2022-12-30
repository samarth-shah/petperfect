// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:petperfect/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = Hive.box('storeData');
  var dio = Dio();
  String imageLink = '';
  bool showButton = false;

  Future<void> getImage() async {
    try {
      final response = await dio.get('https://random.dog/woof.json');
      setState(() {
        imageLink = response.data['url'];
      });
    } catch (e) {
      throw Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> save() async {
    try {
      await box.add(imageLink);
    } catch (e) {
      throw Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    box.isEmpty ? getImage() : imageLink = box.get(0);
  }

  @override
  void dispose() {
    Hive.box('storedata').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetPerfect'),
      ),
      floatingActionButton: !showButton
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await save();
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Icon(Icons.arrow_right_alt_rounded),
            ),
      body: imageLink == ''
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SizedBox(
                height: size / 2,
                child: Image.network(
                  imageLink,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        showButton = true;
                      });
                    });
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
