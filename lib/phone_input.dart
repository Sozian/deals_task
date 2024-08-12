import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneSelected = true;

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      String apiUrl =
          "http://devapiv4.dealsdray.com/api/v2/user/otp"; // my api key
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = _isPhoneSelected
          ? {"phone": _inputController.text}
          : {"email": _inputController.text};

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: json.encode(body),
        );

        if (response.statusCode == 200) {
          // Successfully sent OTP
          Navigator.pushNamed(context, '/otp_verification');
        } else {
          //for  Handling server errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to send OTP: ${response.statusCode}')),
          );
        }
      } catch (e) {
        //  for Handling network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error occurred: $e')),
        );
      }
    }
  }

// form validation
  
  String? _validateInput(String? value) {
    if (_isPhoneSelected) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      } else if (value.length < 10) {
        return 'Phone number must be at least 10 digits';
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'Phone number must contain only digits';
      }
    } else {
      if (value == null || value.isEmpty) {
        return 'Please enter your email address';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.network(
                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAABMlBMVEX',
                height: 100,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Phone'),
                  Switch(
                    value: !_isPhoneSelected,
                    onChanged: (value) {
                      setState(() {
                        _isPhoneSelected = !value;
                        _inputController.clear();
                      });
                    },
                  ),
                  Text('Email'),
                ],
              ),
              TextFormField(
                controller: _inputController,
                keyboardType: _isPhoneSelected
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: _isPhoneSelected
                      ? 'Enter your phone number'
                      : 'Enter your email address',
                ),
                validator: _validateInput,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOTP,
                child: Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
