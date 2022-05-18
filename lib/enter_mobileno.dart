import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:autofill_auth/verify_phone.dart';
import 'verify_phone.dart';

class EnterMobile extends StatefulWidget {
  const EnterMobile({Key? key}) : super(key: key);

  @override
  State<EnterMobile> createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  final TextEditingController _mobileController = TextEditingController();
  void submit() async {
    if (_mobileController.text == "") return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VerifyPhone(_mobileController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Please Enter Your Mobile Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 27,
            ),
            const Text(
              "You'll receive a 6 digit code\n to verify next.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: _screenWidth - 70,
              height: 52,
              //padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                  ),
                  left: BorderSide(
                    width: 1.0,
                  ),
                  right: BorderSide(
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(children: [
                const SizedBox(
                  width: 11,
                ),
                SizedBox(
                    height: 40,
                    width: 40,
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child:
                            Image.asset('asset/Image/IndianFlag_image.jpg'))),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '+91 -',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                        hintText: 'Mobile Number', border: InputBorder.none),
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text('CONTINUE'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2E3B62),
                    minimumSize: Size(_screenWidth - 70, 50),
                    maximumSize: Size(_screenWidth - 50, 50),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
