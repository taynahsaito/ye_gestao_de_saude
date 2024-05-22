import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isCameraReady = false;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    try {
      await _controller.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraReady = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _captureImage() async {
    try {
      final imageFile = await _controller.takePicture();
      setState(() {
        _imageFile = imageFile;
      });

      final imageBytes = await imageFile.readAsBytes();
      await analyzeImage(imageBytes);
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> analyzeImage(Uint8List imageBytes) async {
    try {
      // Simular análise de imagem (resultado fixo)
      String result = 'Exame médico detectado: Hemograma';
      print('Resultado da análise: $result');
    } catch (e) {
      print('Erro ao analisar a imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Column(
        children: [
          if (_isCameraReady)
            Expanded(
              child: CameraPreview(_controller),
            )
          else
            Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(File(_imageFile!.path)),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        child: Icon(Icons.camera),
      ),
    );
  }
}
