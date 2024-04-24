import 'package:flutter/material.dart';
import 'package:plantai_main/widgets/custom_button.dart';
import 'package:plantai_main/widgets/green_color_btn.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ProfilePage(),
      theme: ThemeData(primarySwatch: Colors.green),
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A994E),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // Add functionality to settings icon
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/plantpng.png'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'John Doe',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF386641),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Farmer',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF386641),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20.0),
            GreenOutlinedButton(
              onPressed: () {
                // Handle edit profile button press
              },
              text: 'Edit Profile',
              icon: Icons.edit,
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xFF386641)),
              title: const Text('john.doe@example.com',
                  style: TextStyle(
                      color: Color(0xFF386641), fontWeight: FontWeight.w400)),
              onTap: () {
                // Add functionality to email tile
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xFF386641)),
              title: const Text('+91 1234567890',
                  style: TextStyle(
                      color: Color(0xFF386641), fontWeight: FontWeight.w400)),
              onTap: () {
                // Add functionality to phone tile
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFF386641)),
              title: const Text('Mumbai, INDIA',
                  style: TextStyle(
                      color: Color(0xFF386641), fontWeight: FontWeight.w400)),
              onTap: () {
                // Add functionality to location tile
              },
            ),
          ],
        ),
      ),
    );
  }
}
