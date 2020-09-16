import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  final LocalStorage storage = new LocalStorage('food_history');
  File imageURI;
  String result;
  String path;
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  void classifyImage(BuildContext context) async {
    List showData = storage.getItem('foods');
    if (showData == null) {
      showData = [];
      storage.setItem('foods', showData);
    }
    FormData formData =
        new FormData.fromMap({"file": await MultipartFile.fromFile(path)});
    try {
      var response =
          await Dio().post("http://192.168.1.132/upload", data: formData);
      dynamic parsedJson = json.decode(response.data.toString());
      setState(() {
        result =
            "${parsedJson['class']}\n${parsedJson['score'].toStringAsFixed(2)} %\nCalorie ${parsedJson['calories']} Cal.\n Ref1:${parsedJson['Reference1']}\n Ref2:${parsedJson['Reference2']}";
      });
      var iso8601string = new DateTime.now().toIso8601String();
      var newData = {
        "empname": "",
        "department": "",
        "NameFood": parsedJson['class'],
        "timestamp": iso8601string
      };
      showData.add(newData);
      storage.setItem('foods', showData);
    } catch (e) {
      setState(() {
        result = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/food_bg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imageURI == null
                      ? Text('No image selected',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 24,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-1.5, -1.5),
                                    color: Colors.white),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(1, -1.5),
                                    color: Colors.white),
                                Shadow(
                                    // topRight
                                    offset: Offset(1, 1.5),
                                    color: Colors.white),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-1.5, 1.5),
                                    color: Colors.white),
                              ]))
                      : Image.file(imageURI,
                          width: 224, height: 224, fit: BoxFit.cover),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: RaisedButton(
                        onPressed: () => getImageFromCamera(),
                        child: Text('Take a Picture From Camera'),
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: RaisedButton(
                        onPressed: () => getImageFromGallery(),
                        child: Text('Select Image From Gallery'),
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: RaisedButton(
                        onPressed: () => classifyImage(context),
                        child: Text('SCAN !!'),
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      )),
                  result == null
                      ? Text('Result',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              inherit: true,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-1, -1.5),
                                    color: Colors.white),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(1.5, -1.5),
                                    color: Colors.white),
                                Shadow(
                                    // topRight
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.white),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-1, 1.5),
                                    color: Colors.white),
                              ]))
                      : Text(result,
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 18))
                ])));
  }
}
