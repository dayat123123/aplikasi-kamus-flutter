import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 39, 35, 35),
        body: ListView(
          children: [
            SizedBox(
              height: Get.height * 0.3,
              width: Get.width * 0.5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: Get.width * 0.5,
              width: Get.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://slkbankum.com/api_app/logo-splash.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
