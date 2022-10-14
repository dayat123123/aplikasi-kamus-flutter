// ignore_for_file: unnecessary_const, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamus_banjar/daftarkosakata.dart';
import 'package:kamus_banjar/indoinggris.dart';
import 'package:kamus_banjar/main.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Center(
            child: Text(
          "Kamus 3 Bahasa",
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ClipPathClass(),
                child: Container(
                  height: 150,
                  width: Get.width,
                  color: const Color.fromARGB(255, 36, 36, 36),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ClipPath(
                      child: Container(
                        height: Get.height * 0.4,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: const NetworkImage(
                                      "http://anaknya.slkbankum.com/assets/final.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.001,
                width: Get.width * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const IndoInggris()),
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      child: const Center(
                        child: const Text(
                          "Mulai",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // child: RaisedButton(onPressed: () {}),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 70, 70, 70)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.001,
                width: Get.width * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const DaftarKosakata()),
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 50,
                      child: const Center(
                        child: const Text(
                          "Daftar Kosakata",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // child: RaisedButton(onPressed: () {}),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 70, 70, 70)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class IconsMenu {
  static const items = <IconMenu>[
    bookmark,
    Register,
  ];

  static const bookmark = IconMenu(
    text: 'Login',
    icon: Icons.login_outlined,
  );
  static const Register =
      IconMenu(text: 'Register', icon: Icons.app_registration);
}

class IconMenu {
  final String text;
  final IconData icon;

  const IconMenu({
    required this.text,
    required this.icon,
  });
}
