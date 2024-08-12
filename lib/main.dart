import 'package:flutter/material.dart';
import 'company_window.dart';
import 'phone_input.dart';
import 'otp_verification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Verification App',
      initialRoute: '/',
      routes: {
        '/': (context) => CompanyWindow(),
        '/phone_input': (context) => PhoneInput(),
        '/otp_verification': (context) => OTPVerification(),
        '/home': (context) => HomePage(), // Replace with your home page
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

