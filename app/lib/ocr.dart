import 'dart:convert';
import 'dart:io';

import 'package:fir_analysis/fir_new.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  List<String> ipcSections = [];

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _sendImageToServer(String imagePath) async {
    try {
      var uri = Uri.parse('http://10.255.2.10:5000/detect_text');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully received response
        var responseBody = await response.stream.bytesToString();

        Map<String, dynamic> jsonData = jsonDecode(responseBody);

        // Extract IPC sections from the response
        List<String> ipcSections = jsonData['ipc_section'];
        List<String> text = jsonData['text'].cast<String>();
      } else {
        // Handle error
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception while sending image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Analysis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  )
                : const Text('No image selected'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: const Text('Select Image from Gallery'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: const Text('Open Camera'),
            ),
            _selectedImage != null
                ? ElevatedButton(
                    onPressed: () => _sendImageToServer(_selectedImage!.path),
                    child: const Text('Send Image to Server'),
                  )
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FIRForm(
                              ipcSections: ipcSections,
                              description: '',
                            )));
              },
              child: const Text('move to fir form'),
            ),
          ],
        ),
      ),
    );
  }
}
