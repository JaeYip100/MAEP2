import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mae_assignment/firebase_options.dart';
import 'package:mae_assignment/navigator/bottom_navigation.dart';

String searchText=""; 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      title: 'Peer Tutoring App',
      theme: ThemeData(
primarySwatch: Colors.blue,
      ),
      home: const BottomNavigation(role: "Tutee"),
    )
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Peer Tutoring App',
//       theme: ThemeData(
// primarySwatch: Colors.blue,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
 
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [Color.fromARGB(255, 125, 180, 225), Color.fromARGB(255, 28, 95, 239)]),
//       ),
//       child: const Scaffold(
//         backgroundColor: Colors.transparent,
//         body: AuthenticationPage(),
//       ),
//     );
//   }
// }
// class LoginPageBody extends StatefulWidget {
//   const LoginPageBody({super.key});

//   @override
//   State<LoginPageBody> createState() => LoginPageBodyState();
// }

// class LoginPageBodyState extends State<LoginPageBody> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   Widget _icon() {
//     return Container(
//       width: 100, // Adjusted size for icon container
//       height: 100,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white, width: 2),
//         shape: BoxShape.circle, // Made it circular
//       ),
//       child: const Icon(
//         Icons.person, // Added a sample icon
//         color: Colors.white,
//         size: 50,
//       ),
//     );
//   }


//   Widget _inputField(String hintText, TextEditingController controller,
//     {bool isPassword = false}) {
//     var border = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(18),
//       borderSide: const BorderSide(color: Colors.white),
//     );
//     return TextField(
//       obscureText: isPassword, // Added support for password field
//       style: const TextStyle(color: Colors.white),
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.white),
//         enabledBorder: border,
//         focusedBorder: border,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _icon(),
//             const SizedBox(height: 20), // Added spacing between widgets
//             _inputField("Email", emailController),
//             const SizedBox(height: 20),
//             _inputField("Password", passwordController, isPassword: true),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 // Add login logic here
//                 try{
//                   AuthRepository().login(emailController, passwordController);
//                 }
//                 catch (e)
//                 {
//                   CustomAlertDialog().showAlertMessage(
//                     context, 
//                     title: 'Error when logging in', 
//                     body: 'Email or/and password is incorrect.',
//                   );
//                 }
//               },
//               child: const SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   "Login",
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 //Go to sign up page.
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpPage()),
//                 );
//               },
//               child: const SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   "Sign Up",
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AuthenticationPage extends StatefulWidget {
//   const AuthenticationPage({super.key});

//   @override
//   State<AuthenticationPage> createState() => AuthenticationPageState();
// }

// class AuthenticationPageState extends State<AuthenticationPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(), 
//         builder: (context, snapshot) {
//           if (snapshot.hasData)
//           {
//             return const BottomNavigation();
//           }
//           else
//           {        
//             return const LoginPageBody();
//           }
//         },
//       )
//     );
//   }
// }