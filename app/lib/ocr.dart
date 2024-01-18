import 'dart:convert';
import 'dart:io';

import 'package:fir_analysis/fir_new.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class OCR extends StatefulWidget {
  const OCR({Key? key}) : super(key: key);

  @override
  State<OCR> createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String ipcSections = '';
  String desc = '';
  bool isLoading = false;

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          isLoading =
              true; // Set loading to true while waiting for the response
        });

        // Send image to server and receive response
        await _sendImageToServer(_selectedImage!.path);

        // Move to FIRForm screen with necessary arguments
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FIRForm(
              ipcSections: ipcSections,
              description: desc,
            ),
          ),
        );
      }
    } catch (e) {
      print("Error picking image: $e");
    } finally {
      // Set loading to false after the response is received
      setState(() {
        isLoading = false;
      });
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
        print(responseBody);

        // Extract IPC sections from the response
        dynamic ipcSectionsData = jsonData['ipc_section'];
        if (ipcSectionsData is List<dynamic>) {
          ipcSections = ipcSectionsData.join(', ');
        } else if (ipcSectionsData is String) {
          ipcSections = ipcSectionsData;
        }
        desc = jsonData['text'].cast<String>();
        // print(ipcSections.runtimeType);
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
                    fit: BoxFit.cover,
                  )
                : const Text('No image selected'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:
                  isLoading ? null : () => _getImage(ImageSource.gallery),
              child: const Text('Select Image from Gallery'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isLoading ? null : () => _getImage(ImageSource.camera),
              child: const Text('Open Camera'),
            ),
            isLoading
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
