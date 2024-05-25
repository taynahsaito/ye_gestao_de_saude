import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';

class ComprovantePage extends StatefulWidget {
  @override
  _ComprovantePageState createState() => _ComprovantePageState();
}

class _ComprovantePageState extends State<ComprovantePage> {
  File? _imageFile; // Altere para File? para armazenar o arquivo da imagem

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path); // Salve o arquivo da imagem
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar seu comprovante'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Escolher da Galeria'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CameraCamera(
                      onFile: (file) {
                        setState(() {
                          _imageFile = file; // Salve o arquivo da imagem
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: Text('Tirar Foto'),
            ),
            SizedBox(height: 20),
            if (_imageFile != null)
              Image.file(
                _imageFile!, // Use o arquivo da imagem diretamente
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}

