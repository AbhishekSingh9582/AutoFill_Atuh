import 'package:autofill_auth/enter_mobileno.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSelection extends StatefulWidget {
  ProfileSelection({Key? key}) : super(key: key);

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  int? val = -1;

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const EnterMobile()));
                },
                icon: const Icon(
                  Icons.exit_to_app,
                ))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Please Select Your Profile',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: _screenWidth - 30,
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(),
                    left: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                ),
                child: RadioListTile<int>(
                  activeColor: const Color(0xff2E3B62),
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  },
                  title: Row(
                    children: [
                      const Icon(
                        Icons.home,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Shipper',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w400),
                              ),
                              Flexible(
                                child: Text(
                                  'Lorem ispsum dolor sit amet,consectetur adipiscing',
                                  style: TextStyle(fontSize: 13),
                                  //overflow: TextOverflow.visible,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 37,
              ),
              Container(
                width: _screenWidth - 30,
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(),
                    left: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                ),
                child: RadioListTile<int>(
                  activeColor: const Color(0xff2E3B62),
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  },
                  title: Row(
                    children: [
                      const Icon(
                        Icons.bus_alert_outlined,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Transporter',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w400),
                              ),
                              Flexible(
                                child: Text(
                                  'quis non senties dolorem',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileSelection()));
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2E3B62),
                    minimumSize: Size(_screenWidth - 30, 52),
                    maximumSize: Size(_screenWidth - 25, 52),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
