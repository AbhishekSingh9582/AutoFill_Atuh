import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'profile_selection.dart';

class VerifyPhone extends StatefulWidget {
  final String number;
  const VerifyPhone(this.number, {Key? key}) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  void listenOtp() async {
    // await SmsAutoFill().unregisterListener();
    // listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  bool _isLoading = false;
  String _verificationCode = '';
  String _otpCode = '';

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: _otpCode))
          .then((value) {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProfileSelection()),
              (route) => false);
        }
      });
    } catch (e) {
      print(e);
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Verify Phone',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 22),
                Text('Code is sent to ${widget.number}'),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: PinFieldAutoFill(
                    currentCode: _otpCode,
                    codeLength: 6,
                    decoration: const BoxLooseDecoration(
                        radius: Radius.circular(0),
                        gapSpace: 5,
                        strokeColorBuilder:
                            FixedColorBuilder(Color(0xff93d2f3)),
                        bgColorBuilder: FixedColorBuilder(Color(0xff93d2f3))),
                    onCodeChanged: (code) {
                      print("onCodeChanged $code");
                      setState(() {
                        _otpCode = code.toString();
                      });
                    },
                    onCodeSubmitted: (val) {},
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Didn't recieve the code?"),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Request Again',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  child: ElevatedButton(
                    onPressed: _otpCode.length == 6
                        ? _signIn
                        : () {
                            print('not Activete button');
                          },
                    child: const Text('CONTINUE'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff2E3B62),
                      minimumSize: Size(_screenWidth - 70, 50),
                      maximumSize: Size(_screenWidth - 50, 50),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.number}',
        verificationCompleted: (credential) async {
          listenOtp();
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${e.message}')));
        },
        codeSent: (verificationId, token) {
          _verificationCode = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }
}
