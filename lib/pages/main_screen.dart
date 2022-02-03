import 'package:flutter/material.dart';
import 'package:todo/pages/homePage.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Column(
        children: [
          Text('This is Main Screen', style: TextStyle(color: Colors.white),),
          ElevatedButton(
              onPressed: () {
                
                Navigator.pushReplacementNamed(context, '/todo');

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => HomePage(title: "Home"))
                // );

                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => HomePage(title: "Home")),
                //         (route) => true /// Use  Back arrow
                // );

                //Navigator.pushNamed(context, '/todo', /*arguments: {}*/);

                },
              child: const Text('Go to TODO page'))
        ],
      ),
    );
  }
}
