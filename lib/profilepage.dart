

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_profile.dart';
import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  final User? user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, dynamic>?> _fetchUserProfile() async {
    if (widget.user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user!.uid)
          .get();
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<void> _navigateToUpdateProfile(Map<String, dynamic> userData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UpdateProfilePage(user: widget.user, userData: userData),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  Future<void> _navigateToChangePassword() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching profile data.'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('No profile data found.'));
          } else {
            final userData = snapshot.data!;
            String? profileImageUrl = userData['profileImageUrl'];

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/default_avatar.jpg')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 20),

                      // Details Section
                      _buildProfileDetail('Name', userData['name']),
                      _buildProfileDetail('Email', userData['email']),
                      _buildProfileDetail('Role', userData['role']),
                      _buildProfileDetail(
                          'Bio', userData['bio'] ?? 'Not provided'),
                      _buildProfileDetail(
                          'Age', userData['age'] ?? 'Not provided'),
                      _buildProfileDetail(
                          'Gender', userData['gender'] ?? 'Not provided'),
                      _buildProfileDetail(
                          'Phone', userData['phone'] ?? 'Not provided'),
                      _buildProfileDetail(
                        'Date of Birth',
                        userData['dob'] != null
                            ? formatDate(userData['dob'])
                            : 'Not provided',
                      ),
                      const SizedBox(height: 30),

                      // Buttons
                      ElevatedButton(
                        onPressed: () => _navigateToUpdateProfile(userData),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Update Profile'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: _navigateToChangePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Change Password'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String isoDateString) {
    final dateTime = DateTime.parse(isoDateString);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
