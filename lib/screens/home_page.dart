import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai_main/profile.dart';
import 'package:plantai_main/screens/second_screen.dart';
import 'package:plantai_main/settingscreen.dart';
import 'package:plantai_main/widgets/custom_button.dart';
import 'package:plantai_main/widgets/green_color_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imagePath = '';
  String predictionResult = '';
  String leafName = ''; // Added for searching plant info

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

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
        backgroundColor: const Color(0xFF6A994E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Add your desired icon here
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings), // Add your desired icon here
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/plant.png', // Placeholder image
                  height: 250, // Adjust the height as needed
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GreenButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: Icons.add,
                          text: 'Select Image',
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: GreenButton(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: Icons.camera_alt,
                          text: 'Take Photo',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                imagePath.isNotEmpty?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    height: 200,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFA7C957), width: 2),
                        // Green border
                        borderRadius:
                        BorderRadius.circular(10), // Circular edges
                      ),
                      child: imagePath.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // Match the radius of the container
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ) : const SizedBox.shrink(),
                const SizedBox(height: 20.0),
                GreenOutlinedButton(
                  onPressed: () => _predictImage(),
                  icon: Icons.online_prediction,
                  text: 'Predict',
                ),
                const SizedBox(height: 20.0),
                if (predictionResult.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ac_unit,
                        color: Color(0xFF386641),
                      ),
                      const Text(
                        "Result: ",
                        style: TextStyle(
                            color: Color(0xFF386641),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(predictionResult,
                          style: const TextStyle(
                              color: Color(0xFFA7C957),
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),

                // New functionality for searching plant info
                const SizedBox(height: 20.0),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Plant Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    leafName = value; // Update leafName when the text field value changes
                  },
                ),

                const SizedBox(height: 20.0),

                GreenOutlinedButton(
                  onPressed: () {
                    // Call _fetchPlantInfo with the entered leafName
                    _fetchInfo(leafName);
                  },
                  icon: Icons.search,
                  text: 'Search Plant Info',
                ),
              ],
            ),
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
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://8d0c-103-226-6-209.ngrok-free.app/predict'));

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
            content: const Text(
                "Failed to get proper response from the server. Please select another image."),
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

  _fetchInfo(String query) async {
    try {
      var apiUrl = 'https://en.wikipedia.org/api/rest_v1/page/summary/$query';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print(response.body);
        var responseData = json.decode(response.body);

        if (responseData.containsKey('extract')) {
          // Extract found, show information
          var info = responseData['extract'];

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Information about: $query"),
                content: SingleChildScrollView(
                  child: Text(info),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        } else {
          // No extract found, show an error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("No Information Available"),
                content: Text("Sorry, no information was found for: $query"),
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
        }
      } else {
        // Handle HTTP error
        throw Exception('Failed to fetch information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching information: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to fetch information. Please try again later."),
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
    }
  }
}