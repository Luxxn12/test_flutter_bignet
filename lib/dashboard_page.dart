// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_bignet/core/constants/colors.dart';
import 'dart:convert';
import 'main.dart'; // Import main.dart to navigate back to the login page

class DashboardPage extends StatefulWidget {
  final String token;
  const DashboardPage({super.key, required this.token});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Map<String, dynamic> _userData;
  bool _isLoading = true;

  Future<void> _fetchUserData() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _userData = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load user data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _logout() {
    // Navigate back to the LoginPage and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LoginPage()), // Navigate back to LoginPage
      (Route<dynamic> route) => false, // Remove all routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Dashboard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.yellow)),
        backgroundColor: AppColors.bg,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: AppColors.white,
            onPressed: _logout, // Logout function
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 62,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/200?img=4'),
                          radius: 60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Personal Data',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('User ID',
                          style: TextStyle(color: AppColors.white)),
                      Text('${_userData['id']}',
                          style: const TextStyle(color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Name',
                          style: TextStyle(color: AppColors.white)),
                      Text('${_userData['firstName']} ${_userData['lastName']}',
                          style: const TextStyle(color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Email',
                          style: TextStyle(color: AppColors.white)),
                      Text('${_userData['email']}',
                          style: const TextStyle(color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
