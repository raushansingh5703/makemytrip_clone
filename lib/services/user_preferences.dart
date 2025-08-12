import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyUsers = "users"; // Store JSON {email: password}
  static const String _keyIsLoggedIn = "is_logged_in";
  static const String _keyCurrentUser = "current_user"; // Track logged in email

  /// Login or Signup based on existing data
  static Future<Map<String, dynamic>> loginOrSignup(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Get stored users
    Map<String, String> users = {};
    String? usersJson = prefs.getString(_keyUsers);
    if (usersJson != null) {
      users = Map<String, String>.from(jsonDecode(usersJson));
    }

    // If email exists → try login
    if (users.containsKey(email)) {
      if (users[email] == password) {
        await prefs.setBool(_keyIsLoggedIn, true);
        await prefs.setString(_keyCurrentUser, email);
        return {"success": true, "message": "Login successful! Welcome back!"};
      } else {
        return {"success": false, "message": "Wrong password"};
      }
    }

    // If email doesn't exist → signup
    users[email] = password;
    await prefs.setString(_keyUsers, jsonEncode(users));
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyCurrentUser, email);
    return {"success": true, "message": "Signup successful! Welcome!"};
  }

  /// Check if email is registered
  static Future<bool> isEmailRegistered(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString(_keyUsers);
    if (usersJson == null) return false;

    Map<String, String> users = Map<String, String>.from(jsonDecode(usersJson));
    return users.containsKey(email);
  }

  /// Forgot Password
  static Future<Map<String, dynamic>> resetPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();

    String? usersJson = prefs.getString(_keyUsers);
    if (usersJson == null) {
      return {"success": false, "message": "No users found"};
    }

    Map<String, String> users = Map<String, String>.from(jsonDecode(usersJson));

    if (!users.containsKey(email)) {
      return {"success": false, "message": "Email not found"};
    }

    users[email] = newPassword;
    await prefs.setString(_keyUsers, jsonEncode(users));
    return {"success": true, "message": "Password updated successfully!"};
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
    await prefs.remove(_keyCurrentUser);
  }

  /// Check login status
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Get current logged-in email
  static Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUser);
  }
}
