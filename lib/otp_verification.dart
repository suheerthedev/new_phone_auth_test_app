import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_test/home.dart';

class OtpVerification extends StatefulWidget {
  final String verificationId;
  const OtpVerification({super.key, required this.verificationId});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController otpCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: otpCont,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Enter your otp'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: otpCont.text.trim());

                              FirebaseAuth.instance.signInWithCredential(credential).then((value){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                              });

                    } catch (e) {
                      throw Exception(e.toString());
                    }
                  },
                  child: const Text("Verify"))
            ],
          ),
        ),
      )),
    );
  }
}
