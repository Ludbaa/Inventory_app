import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int quantity;

  Item({required this.name, required this.quantity});
}