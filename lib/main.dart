import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:petperfect/model/store_data.dart';
import 'package:petperfect/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StoreDataAdapter());
  await Hive.openBox('storeData');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pet Perfect',
      home: SplashScreen(),
    );
  }
}
