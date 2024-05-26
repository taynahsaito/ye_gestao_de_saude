import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras = []; //temos varias cameras no smartphone e temos que armazená-las (e pegar a padrao)
  CameraController? controller;
  XFile? imagem;
  Size? size;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async{
    try{
      cameras = await availableCameras();
      _startCamera();

    } on CameraException catch(e){
      print(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty){
      print("câmera nao foi encontrada"); //relacionado com a permissao das cameras
    }
    else {
      _previewCamera(cameras.first); //vai fazer a instanciacao do controle e mostrar a camera na tela
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera, 
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    try{
      await cameraController.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }


    if(mounted){
      setState(() { //atualizar a tela conforme o controller for inicializao
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: const Text("camera"),
      ),
      body: Container(
        child: Center (child: _arquivosWidget()),
      ),
      floatingActionButton: (imagem != null) ? FloatingActionButton.extended(onPressed: () => Navigator.pop(context),label: Text("finalizar")) : null, 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _arquivosWidget (){
    return Container (
      width: size!.width - 50,
      height: size!.height - (size!.height - 3),
      child: imagem == null? _cameraPreviewWidget() : Image.file(File(imagem!.path), fit: BoxFit.contain),
    );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text("Widget para camera que nao esta disponivel");
    }
    else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [ 
          CameraPreview(controller!),
          _botaoCapturaWidget(),
        ]
      );
    }
  }


  _botaoCapturaWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom:24),
      child: CircleAvatar(
        radius: 32, 
        backgroundColor: Colors.black,
        child: IconButton(
          icon: Icon
          (Icons.camera_alt,
          color: Colors.white,
          size: 30),
          onPressed: tirarFoto(),
          )
      )
      );
  }

  tirarFoto() async {
    final CameraController? cameraController = controller;

    if (cameraController != null && cameraController.value.isInitialized){
      try{
        XFile file = await cameraController.takePicture();
        if(mounted) {
          setState(() {
            imagem = file;
          });
        }
      } on CameraException catch (e) {
        print(e.description);
      }
    } 
  }

}
