import 'package:flutter/material.dart';
import 'package:jajal_app/user_service.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({Key? key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name.first} ${user.name.last}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 154, 240, 5), // Warna awal (top)
              Color.fromARGB(255, 40, 188, 230), // Warna akhir (bottom)
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildInfoItem('Location', user.location),
            const SizedBox(height: 20),
            _buildInfoItem('Email', user.email),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0), //
          ),
        ),
        Divider(color: const Color.fromARGB(255, 0, 0, 0), height: 20),
      ],
    );
  }
}
