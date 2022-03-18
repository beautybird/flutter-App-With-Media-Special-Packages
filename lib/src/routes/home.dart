import 'package:flutter/material.dart';
import 'package:special/src/routes/videoImage.dart';

class Home extends StatelessWidget {
  static const routeName='/homePage';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Home Page'),),
      body: ListView(
        children: [
          const SizedBox(height: 30.0,),
          TextButton(
            onPressed: ()=> Navigator.pushNamed(context, VideoImage.routeName),
            child:const Text(
              'show media',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          const SizedBox(height: 20.0,),
        ],
      ),
    );
  }
}
