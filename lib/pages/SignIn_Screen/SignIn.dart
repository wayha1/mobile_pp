import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/component/my_button_Bar.dart';
import 'package:project_practicum/pages/HomeScreen/Home.dart';
import 'package:project_practicum/pages/SignUp_Screen/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}



class _SignInState extends State<SignIn> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _validateUsername = false;
  bool _validatePassword = false;
  //late String accessToken;

  @override
  void initState() {
    super.initState();
    // Execute the delayed initialization of SharedPreferences
    // Future.delayed(Duration.zero, () {
    //   _initSharedPreferences();
    // });
  }

  // Future<void> _initSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final storedToken = prefs.getString('access_token');
  //   print('Stored Access Token: $storedToken');
  // }


  Future<void> _signIn() async {
    setState(() {
      _validateUsername = _username.text.isEmpty;
      _validatePassword = _password.text.isEmpty;
    });

    if (!_validateUsername && !_validatePassword) {
      final url = Uri.parse('http://10.0.2.2:5000/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _username.text,
          'password': _password.text,
        }),
      );





      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final accessToken = responseData['access_token'];

        // Print the entire response body for debugging
        print('Response Body: ${response.body}');

        // Store the access token locally using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);

        // Retrieve the access token from SharedPreferences
        final storedToken = prefs.getString('access_token');
        print('Stored Access Token: $storedToken');

        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Account(accessToken: accessToken)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WELCOME TO OUR APP',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        'Sign up or log in to \nenjoy your time.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'lib/image/d.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email Address",
                    errorText: _validateUsername?'email cannot be null':null,
                  ),
                  controller: _username,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                    labelText: "Password",
                    errorText: _validatePassword?'password cannot be null':null,
                  ),
                  controller: _password,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, right: 20),
                    child: TextButton(
                      onPressed: _signIn,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8 ,vertical: 8),
                  child: Text(
                    'OR login with',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 130, top: 20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        // Add your logic for Google login here
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        fixedSize: Size(400, 60),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/image/go.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Login with Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('cambodia',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500
                    ),
                  ),
                  Text('E-Library Ltd.',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500
                    ),
                  ),
                  Text('Tos Ran',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


