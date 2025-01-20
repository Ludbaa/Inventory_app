// models/admin.dart

import 'package:hive/hive.dart';

part 'admin.g.dart'; // Ini adalah file yang dihasilkan oleh build_runner

@HiveType(typeId: 2) // Pastikan typeId unik
class Admin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  String password; // Mutable agar bisa diubah

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
}