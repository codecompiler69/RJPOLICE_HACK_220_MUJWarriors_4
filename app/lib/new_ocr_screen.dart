import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:fir_analysis/result.dart';

class NewOcrScreen extends StatefulWidget {
  const NewOcrScreen({super.key});

  @override
  State<NewOcrScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NewOcrScreen> with WidgetsBindingObserver {
  bool isPermissionGranted = false;
  late final Future<void> future;

  CameraController? cameraController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    future = requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopCamera();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        cameraController != null &&
        cameraController!.value.isInitialized) {
      startCamera();
    }
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    isPermissionGranted = status == PermissionStatus.granted;
  }

  void initCameraController(List<CameraDescription> cameras) {
    if (cameraController != null) {
      return;
    }
    CameraDescription? camera;
    for (var a = 0; a < cameras.length; a++) {
      final CameraDescription current = cameras[a];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }
    if (camera != null) {
      cameraSelected(camera);
    }
  }

  Future<void> cameraSelected(CameraDescription camera) async {
    cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await cameraController?.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void startCamera() {
    if (cameraController != null) {
      cameraSelected(cameraController!.description);
    }
  }

  void stopCamera() {
    if (cameraController != null) {
      cameraController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                    future: availableCameras(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        initCameraController(snapshot.data!);
                        return Center(
                          child: CameraPreview(cameraController!),
                        );
                      } else {
                        return const LinearProgressIndicator();
                      }
                    }),
              Scaffold(
                appBar: AppBar(
                  title: const Text('Text Recognition Sample'),
                ),
                backgroundColor:
                    isPermissionGranted ? Colors.transparent : null,
                body: isPermissionGranted
                    ? Column(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ElevatedButton(
                              onPressed: isLoading ? null : scanImage,
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Scan Text'),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: const Text(
                            'Camera Permission Denied',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ],
          );
        });
  }

  Future<void> scanImage() async {
  if (cameraController == null || isLoading) {
    return;
  }

  setState(() {
    isLoading = true;
  });

  final navigator = Navigator.of(context);

  try {
    final pictureFile = await cameraController!.takePicture();
    final file = File(pictureFile.path);
    print(file);

    // Send the image to the Flask server
    final detectedText = await sendImageToServer(file);
    print('detectedText: ${detectedText}');

    // Navigate to the result screen and pass the detected text
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(text: detectedText),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('An error occurred when scanning text'),
      ),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}


  Future<String> sendImageToServer(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.7:5000/detect_text'),
    );

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Handle the response from the server
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseBody);
        return decodedResponse['text'];
      } else {
        print('Error: ${response.reasonPhrase}');
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: $e';
    }
  }
}
