import 'package:autofill_auth/profile_selection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'enter_mobileno.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Fill Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          buttonTheme: const ButtonThemeData(buttonColor: Color(0x002E3B62)),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
              bodyText2: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              bodyText1: TextStyle(fontSize: 18, color: Colors.white))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _langItem = ['English', 'Hindi', 'Sanskrit'];
  String? _selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo_library,
            size: 40,
          ),
          const SizedBox(
            height: 43,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text(
              'Please Select your language',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text(
              'You can change the language\n at any time',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 270,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 13),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: _selectedLanguage,
                  isExpanded: true,
                  iconSize: 38,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  },
                  items: _langItem
                      .map((item) => _buildDropMenuItem(item))
                      .toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EnterMobile()));
              },
              child: const Text('NEXT'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2E3B62), //, // ,
                // onPrimary: const Color(0x002e3b62),
                minimumSize: const Size(270, 50),
                maximumSize: const Size(280, 50),
              ),
            ),
          )
        ],
      )),
    );
  }

  DropdownMenuItem<String> _buildDropMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }
}
