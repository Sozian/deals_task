import 'package:flutter/material.dart';

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneSelected = true;

  void _sendOTP() {
    if (_formKey.currentState!.validate()) {
      // Implement API call to send OTP via phone or email here
      Navigator.pushNamed(context, '/otp_verification');
    }
  }

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
              // Add the image above the toggle button
              Image.network(
                // 'data:image/png;base64,498cBP2b8Hm8pgIHL3h6UUXFhoGqbhIaNMWJZ8oaiMqi1n8smRA3RwaJWvvTyOAKMxeHPPt89800Yd93c9ck4WgVsH7YMpmQFn4Ewuhp7WNX+BGHcetDuQOl6fNZfyburCyXAryxqCQN1dtIj1yXItUIULfVnz7yieXo5qiRcerswFZa7WmmvkdzNFKKzMWFAW+QDCnoP3CjVaF2EbxwbHlwbHcYlYWnbYybSGfIxOOjMuC4J7y/Y9i9qEbw/m2JQN625dfON+WtMk8eks435ZMzdPHjeF8m9MGIOqyC+fbnPNpxaX4OB9dOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9VOB9V3prvv7BLSXeW6pX0AAAAAElFTkSuQmCC',
                'data:image/png;base64,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',
                height: 100, // Adjust the height as needed
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
