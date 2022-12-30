import 'package:hive/hive.dart';

part 'store_data.g.dart';

@HiveType(typeId: 0)
class StoreData extends HiveObject {
  @HiveField(0)
  late String imageUrl;
}
