// ignore_for_file: prefer_void_to_null, unnecessary_new, curly_braces_in_flow_control_structures, unused_local_variable, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_banjar/listdata.dart';
import 'dart:convert';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarKosakata extends StatefulWidget {
  const DaftarKosakata({Key? key}) : super(key: key);

  @override
  State<DaftarKosakata> createState() => _DaftarKosakataState();
}

Future<SharedPreferences> preferences = SharedPreferences.getInstance();

class _DaftarKosakataState extends State<DaftarKosakata> {
  final List<Kosakata> _list = [];
  final List<Kosakata> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    var url = 'http://percobaan.slkbankum.com/api/kosakata.php';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        for (var u in data) {
          _list.add(Kosakata.fromJson(u));
          loading = false;
        }
      });
    }
  }

  final TextEditingController controller = new TextEditingController();
  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {
        return;
      });
    }
    _list.forEach((f) {
      if (f.kata_dasar.contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final ScrollController _scroll = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
        elevation: 4,
        title: Column(
          children: [
            Row(
              children: const [
                Center(
                  child: Text(
                    "Kamus 3 Bahasa",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari kosakata",
                    hintStyle: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: onSearch,
                  controller: controller,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'List Kosakata',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: SizedBox(
                height: Get.height,
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    // ignore: prefer_is_empty
                    : _search.length != 0 || controller.text.isNotEmpty
                        ? ListView.builder(
                            controller: _scroll,
                            itemCount: _search.length,
                            itemBuilder: (context, index) {
                              final b = _search[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Card(
                                        elevation: 0,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 24,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        b.kata_dasar,
                                                        // ignore: prefer_const_constructors
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        b.kata_daerah,
                                                        // ignore: prefer_const_constructors
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : ListView.builder(
                            controller: _scroll,
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              final a = _list[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Card(
                                        elevation: 0,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 24,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        a.kata_dasar,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        a.kata_daerah,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
              ),
            ),

            // batas header
          ],
        ),
      ),
    );
  }
}
