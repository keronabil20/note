import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/layout/home_screen.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Lottie.asset(
              'assets/pencil.json',
            ),
          ),
          SizedBox(height:50 ,),
          MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeLayout()));
              },
              color: Colors.green[300],
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text('Go to Home ')),
        ],
      ),
    );
  }
}
