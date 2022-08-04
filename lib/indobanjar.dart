import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kamus_banjar/inggrisindo.dart';
import 'package:kamus_banjar/IndoInggris.dart';
import 'package:kamus_banjar/indobanjar.dart';
import 'package:kamus_banjar/indobanjarbetul.dart';
import 'package:kamus_banjar/BanjarInggris.dart';
import 'package:kamus_banjar/InggrisBanjar.dart';
import 'package:kamus_banjar/main.dart';
import 'package:kamus_banjar/function.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class IndoBanjar extends StatefulWidget {
  const IndoBanjar({Key? key}) : super(key: key);

  @override
  State<IndoBanjar> createState() => _IndoBanjarState();
}

class _IndoBanjarState extends State<IndoBanjar> {
  late TextEditingController _textEditingController;
  String url = '';
  var data;
  String output = 'Initial Output';
  // untuk speech to text
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
    _textEditingController = new TextEditingController();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _textEditingController.text = result.recognizedWords;
    });
  }
  // batas

  OutlineInputBorder _inputformdeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
          width: 1.0,
          color: Color.fromARGB(255, 86, 87, 88),
          style: BorderStyle.solid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 35, 35),
        automaticallyImplyLeading: false,
        title: Text(
          "Banjarese ➨ Indonesia",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton<IconMenu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              switch (value) {
                case IconsMenu.bookmark:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => IndoInggris()),
                  );
                  break;
                case IconsMenu.Register:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InggrisIndo()),
                  );
                  break;
                case IconsMenu.Banjar:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => IndoBanjar()),
                  );
                  break;
                case IconsMenu.Idbanjar:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => IndoBanjarBetul()),
                  );
                  break;
                case IconsMenu.Inggris:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InggrisBanjar()),
                  );
                  break;
                case IconsMenu.Idinggris:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BanjarInggris()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => IconsMenu.items
                .map((item) => PopupMenuItem<IconMenu>(
                      value: item,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(item.icon, color: Colors.pink),
                        title: Text(item.text),
                      ),
                    ))
                .toList(),
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 11.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.white),
                  child: Form(
                    child: TextFormField(
                      onChanged: (value) {
                        url = 'https://vnev.herokuapp.com/api4?query=' +
                            value.toString();
                      },
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Masukkan kata",
                        contentPadding: const EdgeInsets.only(left: 24.0),
                        enabledBorder: _inputformdeco(),
                        focusedBorder: _inputformdeco(),
                        // removing the input border
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () async {
                  data = await fetchdata(url);
                  var decoded = jsonDecode(data);
                  setState(() {
                    output = decoded['output'];
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Terjemahan: $output",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}

class IconsMenu {
  static const items = <IconMenu>[
    bookmark,
    Register,
    Banjar,
    Idbanjar,
    Inggris,
    Idinggris
  ];

  static const bookmark = IconMenu(
    text: 'Indonesia -> Inggris',
    icon: Icons.flag,
  );
  static const Register = IconMenu(
    text: 'Inggris -> Indonesia',
    icon: Icons.flag,
  );
  static const Banjar = IconMenu(
    text: 'Banjarese -> Indonesia',
    icon: Icons.flag,
  );
  static const Idbanjar = IconMenu(
    text: 'Indonesia -> Banjarese',
    icon: Icons.flag,
  );
  static const Inggris = IconMenu(
    text: 'Inggris -> Banjarese',
    icon: Icons.flag,
  );
  static const Idinggris = IconMenu(
    text: 'Banjarese -> Inggris',
    icon: Icons.flag,
  );
}

class IconMenu {
  final String text;
  final IconData icon;

  const IconMenu({
    required this.text,
    required this.icon,
  });
}
