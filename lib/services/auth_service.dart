import 'package:hive/hive.dart';
import '../models/user.dart';

class AuthService {
  final Box<User> userBox = Hive.box<User>('users');

  bool register(String email, String password) {
    if (userBox.values.any((user) => user.email == email)) {
      return false; // Email sudah terdaftar
    }
    userBox.add(User(email: email, password: password));
    return true;
  }

  User? login(String email, String password) {
    for (var user in userBox.values) {
      if (user.email == email && user.password == password) {
        return user; // Berhasil login
      }
    }
    return null; // Gagal login
  }

  bool resetPassword(String email, String newPassword) {
    for (var user in userBox.values) {
      if (user.email == email) {
        userBox.put(userBox.keyAt(userBox.values.toList().indexOf(user)), User(email: email, password: newPassword));
        return true; // Password berhasil direset
      }
    }
    return false; // Email tidak ditemukan
  }
}