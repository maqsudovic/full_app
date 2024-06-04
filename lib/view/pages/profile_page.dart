// EditProfileModal.dart
import 'package:flutter/material.dart';

class EditProfileModal extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Function(String, String, String) onSaveChanges;

  EditProfileModal({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.onSaveChanges,
  }) : super(key: key);

  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    widget.onSaveChanges(firstName, lastName, phoneNumber);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveChanges,
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

// ProfilePage.dart
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _firstName = "John";
  String _lastName = "Doe";
  String _phoneNumber = "+1 (123) 456-7890";

  void _showEditProfileModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditProfileModal(
          firstName: _firstName,
          lastName: _lastName,
          phoneNumber: _phoneNumber,
          onSaveChanges: (firstName, lastName, phoneNumber) {
            setState(() {
              _firstName = firstName;
              _lastName = lastName;
              _phoneNumber = phoneNumber;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg'),
            ),
            SizedBox(height: 16.0),
            Text('$_firstName $_lastName'),
            SizedBox(height: 8.0),
            Text(_phoneNumber),
            Spacer(),
            ElevatedButton(
              onPressed: _showEditProfileModal,
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEditProfileModal,
        child: Icon(Icons.edit),
      ),
    );
  }
}