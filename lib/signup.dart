// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'login.dart'; // Import LoginPage

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   SignUpPageState createState() => SignUpPageState();
// }

// class SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   bool _isTutor = false; // Track the "Tutor" checkbox state
//   bool _isTutee = false; // Track the "Tutee" checkbox state
//   bool isPasswordVisible = false; // Track password visibility
//   bool _isLoading = false;

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> _signUpUser() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//       final name = _nameController.text.trim();

//       // Validation for email format and password length
//       if (email.isEmpty) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Email is required to fill.")),
//           );
//         }
//       } else if (!email.contains("@gmail.com")) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Please enter a valid email with '@gmail.com'.")),
//           );
//         }
//       } else if (password.isEmpty) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Password is required to fill.")),
//           );
//         }
//       } else if (password.length < 6) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Password must be at least 6 characters long.")),
//           );
//         }
//       } else if (_isTutor && _isTutee) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Only choose one role, please try again.")),
//           );
//         }
//       } else if (!_isTutor && !_isTutee) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Please select either Tutor or Tutee.")),
//           );
//         }
//       } else {
//         // Register user with Firebase Auth
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         // Add user details to Firestore
//         await _firestore.collection('Users').doc(cred.user!.uid).set({
//           'name': name,
//           'email': email,
//           'uid': cred.user!.uid,
//           'role': _isTutor ? "Tutor" : "Tutee",
//         });

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Signed up successfully!")),
//           );

//           // Navigate to LoginPage
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginPage()),
//           );
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "An error occurred")),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up")),
//       body: Center(
//         // Example form UI (you can expand on this as needed)
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Name"),
//               ),
//               TextField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: "Email"),
//               ),
//               TextField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: "Password"),
//                 obscureText: !isPasswordVisible,
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _isTutor,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         _isTutor = value ?? false;
//                         if (_isTutor) _isTutee = false; // Ensure only one role is selected
//                       });
//                     },
//                   ),
//                   const Text("Tutor"),
//                   Checkbox(
//                     value: _isTutee,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         _isTutee = value ?? false;
//                         if (_isTutee) _isTutor = false; // Ensure only one role is selected
//                       });
//                     },
//                   ),
//                   const Text("Tutee"),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _signUpUser,
//                 child: _isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text("Sign Up"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart'; // Import LoginPage

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isTutor = false; // Checkbox for "Tutor"
  bool _isTutee = false; // Checkbox for "Tutee"
  bool _isPasswordVisible = false; // Track password visibility
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();

      // Validation for email format and password length
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email is required to fill.")),
        );
      } else if (!email.contains("@gmail.com")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid email with '@gmail.com'.")),
        );
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password is required to fill.")),
        );
      } else if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password must be at least 6 characters long.")),
        );
      } else if (_isTutor && _isTutee) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only choose one role, please try again.")),
        );
      } else if (!_isTutor && !_isTutee) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select either Tutor or Tutee.")),
        );
      } else {
        // Register user with Firebase Auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user details to Firestore
        await _firestore.collection('Users').doc(cred.user!.uid).set({
          'name': name,
          'email': email,
          'uid': cred.user!.uid,
          'role': _isTutor ? "Tutor" : "Tutee",
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signed up successfully!")),
        );

        // Navigate to LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "An error occurred")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _inputField("Full Name", controller: _nameController),
                const SizedBox(height: 20),
                _inputField("Email", controller: _emailController),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 20),

                // Checkbox for "Tutor"
                CheckboxListTile(
                  title: const Text('Tutor'),
                  value: _isTutor,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTutor = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                // Checkbox for "Tutee"
                CheckboxListTile(
                  title: const Text('Tutee'),
                  value: _isTutee,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTutee = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUpUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hintText, {TextEditingController? controller, bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Toggle based on visibility
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
            });
          },
        ),
      ),
    );
  }
}
