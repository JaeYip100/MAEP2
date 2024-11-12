import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UpdateProfilePage extends StatefulWidget {
  final User? user;
  final Map<String, dynamic> userData;

  const UpdateProfilePage({Key? key, required this.user, required this.userData})
      : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? _imageFile;
  String? _profileImageUrl;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;
  DateTime? _selectedDOB;

  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDOB ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
        _selectedDOB = picked;
      });
    }
  }

  Future<void> _saveProfileUpdates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? downloadUrl = _profileImageUrl;

      if (_imageFile != null) {
        String role = widget.userData['role'];
        String folder = role == "Tutor" ? "Users/Tutor" : "Users/Tutee";
        String fileName = '$folder/${widget.user!.uid}/profile.jpg';

        final ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putFile(_imageFile!);
        downloadUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user!.uid)
          .update({
        'profileImageUrl': downloadUrl,
        'bio': _bioController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _gender,
        'dob': _selectedDOB?.toIso8601String(),
        'phone': _phoneController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _profileImageUrl = widget.userData['profileImageUrl'];
    _bioController.text = widget.userData['bio'] ?? '';
    _ageController.text = widget.userData['age'] ?? '';
    _gender = widget.userData['gender'];
    _phoneController.text = widget.userData['phone'] ?? '';
    _selectedDOB = widget.userData['dob'] != null
        ? DateTime.parse(widget.userData['dob'])
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : _profileImageUrl != null
                            ? NetworkImage(_profileImageUrl!)
                            : const AssetImage('assets/default_avatar.jpg')
                                as ImageProvider,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.deepPurple),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // View-only Fields
            _buildReadOnlyField('Name', widget.userData['name']),
            _buildReadOnlyField('Email', widget.userData['email']),
            _buildReadOnlyField('Role', widget.userData['role']),

            const SizedBox(height: 20),

            // Editable Fields
            _buildEditableField('Bio', _bioController),
            _buildEditableField('Age', _ageController, keyboardType: TextInputType.number),
            DropdownButtonFormField<String>(
              value: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 10),
            _buildEditableField('Phone Number', _phoneController,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Date of Birth: ',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  _selectedDOB != null
                      ? '${_selectedDOB!.day}/${_selectedDOB!.month}/${_selectedDOB!.year}'
                      : 'Not set',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
                  onPressed: () => _selectDOB(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfileUpdates,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
