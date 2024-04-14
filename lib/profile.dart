import 'package:flutter/material.dart';

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
              'Elon Musk',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Developer',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button press
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('john.doe@example.com'),
              onTap: () {
                // Add functionality to email tile
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('+91 1234567890'),
              onTap: () {
                // Add functionality to phone tile
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Mumbai, INDIA'),
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
