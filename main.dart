import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Examen2());
}

class Examen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes/No App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YesNoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class YesNoHomePage extends StatefulWidget {
  @override
  _YesNoHomePageState createState() => _YesNoHomePageState();
}

class _YesNoHomePageState extends State<YesNoHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _responseText = '';
  String _imageUrl = '';

  void _fetchAnswer() async {
    if (_controller.text.endsWith('?')) {

      final response = await http.get(Uri.parse('https://yesno.wtf/api'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _responseText = _controller.text;
          _imageUrl = json['image'];
        setState(() {
          
        });
      }
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examen 2 - Daniel Fuentes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_imageUrl.isEmpty) Image.network(_imageUrl)else CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              _responseText,
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Haz una pregunta...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _fetchAnswer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
