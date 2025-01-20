import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/item.dart';
import 'models/user.dart';
import 'models/admin.dart'; // Import Admin model
import 'screens/login_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AdminAdapter()); // Registrasi Admin adapter
  await Hive.openBox<Item>('inventory');
  await Hive.openBox<User>('users');

  // Buka box untuk Admin
  final adminBox = await Hive.openBox<Admin>('admins');

  // Cek apakah admin sudah ada, jika belum buat admin default
  if (adminBox.isEmpty) {
    final admin = Admin(
      id: '1', // ID unik untuk admin
      name: 'Admin',
      email: 'admin@example.com',
      password: 'password123', // Default password
    );
    await adminBox.put(admin.id, admin); // Simpan admin ke dalam box
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management',
      home: LoginScreen(),
    );
  }
}
