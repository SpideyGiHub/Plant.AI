import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai_main/profile.dart';
import 'package:plantai_main/screens/second_screen.dart';
import 'package:plantai_main/settingscreen.dart';
import 'package:plantai_main/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imagePath = '';
  String predictionResult = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Append the picked image file path to the list
      setState(() {
        imagePath = pickedFile.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Add your desired icon here
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings), // Add your desired icon here
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const Text(
              //   '',
              //   style: TextStyle(fontSize: 30.0),
              // ),
              // const SizedBox(height: 20.0),
              Image.asset(
                'assets/Plant AI.png', // Placeholder image
                height: 150, // Adjust the height as needed
              ),
              const SizedBox(height: 20.0),
              imagePath.isNotEmpty
                  ? Image.file(
                File(imagePath),
                height: 120,
                fit: BoxFit.contain, // Set the height of the image
              )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               const SecondScreen()), // Navigate to SecondScreen
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              //     textStyle: const TextStyle(fontSize: 18),
              //   ),
              //   child: const Text('Enter'),
              // ),
              // const SizedBox(height: 20.0),
              GreenOutlinedButton(
                onPressed: () => _pickImage(),
                text: 'Select Image',
              ),
              const SizedBox(height: 20.0),
              GreenOutlinedButton(
                  onPressed: () => _predictImage(),
                  text: 'Predict'
              ),
              const SizedBox(height: 20.0),
              if (predictionResult.isNotEmpty)
                Text(predictionResult),
            ],
          ),
        ),
      ),
    );
  }

  _predictImage() async {
    if (imagePath.isEmpty) {
      // Show alert if no image is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No Image Selected"),
            content: const Text("Please select an image before predicting."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse('https://2512-103-226-6-209.ngrok-free.app/predict'));

    // Add the image to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'imagefile', // This should match the key expected by your server
        imagePath,
      ),
    );

    // Send the request
    var response = await request.send();

    // Check the status code of the response
    if (response.statusCode == 200) {
      // If the request is successful, parse the response
      var responseData = await response.stream.bytesToString();
      // Update UI with response data
      Map<String, dynamic> jsonResponse = json.decode(responseData);
      // Retrieve the "prediction" field from JSON
      setState(() {
        predictionResult = jsonResponse['prediction'];
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to get proper response from the server. Please select another image."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      print('Request failed with status: ${response.statusCode}');
    }
      // If the request fails, handle the error

    }
  }
