import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Settings Example',
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key,});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English'; // Default language
  List<String> languages = ['English', 'Hindi', 'Marathi']; // Available languages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Settings')), // Update app bar title
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(getTranslated(context, 'Language')), // Update list tile text
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
                _changeLanguage(newValue); // Change language
              },
              items: languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, 'Notifications')), // Update list tile text
            trailing: Switch(
              value: false,
              onChanged: (bool value) {
                _updateNotificationSettings(context, value); // Update notification settings
              },
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, 'Dark Mode')), // Update list tile text
            trailing: Switch(
              value: false,
              onChanged: (bool value) {
                _updateDarkModeSettings(context, value); // Update dark mode settings
              },
            ),
          ),
          ListTile(
            title: Text(getTranslated(context, 'Change Password')), // Update list tile text
            onTap: () {
              _navigateToChangePasswordScreen(context); // Navigate to change password screen
            },
          ),
          ListTile(
            title: Text(getTranslated(context, 'About')), // Update list tile text
            onTap: () {
              _navigateToAboutScreen(context); // Navigate to about screen
            },
          ),
        ],
      ),
    );
  }

  // Function to change the language
  void _changeLanguage(String? newLanguage) {
    // You need to implement logic to change the app's language here
    // For demonstration purposes, we'll just print the selected language
    if (kDebugMode) {
      print('Language changed to: $newLanguage');
    }
  }

  // Function to update notification settings
  void _updateNotificationSettings(BuildContext context, bool value) {
    // Placeholder for updating notification settings
    // For demonstration purposes, we'll just show a snackbar
    final snackBar = SnackBar(
      content: Text('Notification settings updated to: $value'),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to update dark mode settings
  void _updateDarkModeSettings(BuildContext context, bool value) {
    // Placeholder for updating dark mode settings
    // For demonstration purposes, we'll just show a snackbar
    final snackBar = SnackBar(
      content: Text('Dark mode settings updated to: $value'),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to navigate to change password screen
  void _navigateToChangePasswordScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    );
  }

  // Function to navigate to about screen
  void _navigateToAboutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutScreen()),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Change Password')), // Update app bar title
      ),
      body: const ChangePasswordForm(),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key,});

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _oldPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: getTranslated(context, 'Old Password'), // Update text
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: getTranslated(context, 'New Password'), // Update text
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: getTranslated(context, 'Confirm New Password'), // Update text
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              // Perform password change logic here
              String newPassword = _newPasswordController.text;
              String confirmPassword = _confirmPasswordController.text;

              // Validate passwords and perform change
              if (newPassword == confirmPassword) {
                // Call a function to change the password
                // For example, you might call an API here to update the password
                // If successful, you can navigate to another screen or show a success message
                // If unsuccessful, you can show an error message to the user
                // Placeholder for now
              } else {
                // Show an error message if passwords don't match
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('New passwords do not match.'),
                  ),
                );
              }
            },
            child: Text(getTranslated(context, 'Change Password')), // Update text
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'About')), // Update app bar title
      ),
      body: Center(
        child: Text(getTranslated(context, 'Plant AI Disease Detection App')), // Update text
      ),
    );
  }
}

// Function to get translated text
String getTranslated(BuildContext context, String key) {
  DemoLocalization? demoLocalization = DemoLocalization.of(context);
  return demoLocalization?.getTranslatedValue(key) ?? key;
}

// Class for managing translations
class DemoLocalization {
  final Locale locale;

  var _selectedLanguage;

  DemoLocalization(this.locale);

  // Function to get DemoLocalization instance
  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  // Function to get translated value
  String getTranslatedValue(String key) {
    switch (key) {
      case 'Settings':
        return _selectedLanguage == 'Hindi'
            ? 'सेटिंग्स'
            : _selectedLanguage == 'Marathi'
            ? 'सेटिंग्स'
            : 'Settings';
      case 'Language':
        return _selectedLanguage == 'Hindi'
            ? 'भाषा'
            : _selectedLanguage == 'Marathi'
            ? 'भाषा'
            : 'Language';
      case 'Notifications':
        return _selectedLanguage == 'Hindi'
            ? 'सूचनाएं'
            : _selectedLanguage == 'Marathi'
            ? 'सूचना'
            : 'Notifications';
      case 'Dark Mode':
        return _selectedLanguage == 'Hindi'
            ? 'डार्क मोड'
            : _selectedLanguage == 'Marathi'
            ? 'डार्क मोड'
            : 'Dark Mode';
      case 'Change Password':
        return _selectedLanguage == 'Hindi'
            ? 'पासवर्ड बदलें'
            : _selectedLanguage == 'Marathi'
            ? 'पासवर्ड बदला'
            : 'Change Password';
      case 'About':
        return _selectedLanguage == 'Hindi'
            ? 'बारे में'
            : _selectedLanguage == 'Marathi'
            ? 'चर्चित करा'
            : 'About';
      case 'Old Password':
        return _selectedLanguage == 'Hindi'
            ? 'पुराना पासवर्ड'
            : _selectedLanguage == 'Marathi'
            ? 'जुना संकेतशब्द'
            : 'Old Password';
      case 'New Password':
        return _selectedLanguage == 'Hindi'
            ? 'नया पासवर्ड'
            : _selectedLanguage == 'Marathi'
            ? 'नविन संकेतशब्द'
            : 'New Password';
      case 'Confirm New Password':
        return _selectedLanguage == 'Hindi'
            ? 'नए पासवर्ड की पुष्टि करें'
            : _selectedLanguage == 'Marathi'
            ? 'नविन संकेतशब्दची पुष्टी करा'
            : 'Confirm New Password';
      case 'About Screen':
        return _selectedLanguage == 'Hindi'
            ? 'बारे में स्क्रीन'
            : _selectedLanguage == 'Marathi'
            ? 'बदला स्क्रीन'
            : 'About Screen';
      default:
        return key;
    }
  }
}
