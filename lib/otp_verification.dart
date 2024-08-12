import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPVerification extends StatefulWidget {
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());

  void _verifyOTP() {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 4) {
      String apiKey = 'your_api_key'; // Replace this with the actual API key
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(apiKey: apiKey),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      counterText: '', // Hide the counter
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        _focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String apiKey;

  HomePage({required this.apiKey});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = ''; // Variable to store fetched data
  bool _isLoading = true; // To show a loading indicator

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final String apiUrl =
        "http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice"; // Replace with your API endpoint
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${widget.apiKey}",
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['data'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _data = 'Failed to load data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _data = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                _data,
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
