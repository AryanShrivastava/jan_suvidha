import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jansuvidha/sign_in.dart';
import 'package:tflite/tflite.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'drawer.dart';

import 'package:jansuvidha/scratchcard.dart';

class Ml_accident extends StatefulWidget {
  @override
  _Ml createState() => _Ml();
}

class _Ml extends State<Ml_accident> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override

  Widget imageCarousel = new Container(
    height: 220.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        NetworkImage(
            'https://thumbs.dreamstime.com/z/cartoon-people-fixing-hole-highway-industrial-city-roadwork-banner-repair-equipment-heavy-machinery-working-pothole-169603809.jpg'),
        NetworkImage(
            'https://thumbs.dreamstime.com/z/car-highway-falling-asphalt-hole-cartoon-man-looking-shock-automobile-pothole-accident-cityscape-backdrop-flat-193690324.jpg'),
        NetworkImage(
            'https://media.istockphoto.com/vectors/gift-card-with-blue-bow-vector-id1179439557?k=6&m=1179439557&s=612x612&w=0&h=Gj7OWfomEmRDIZZ_DbA15QImyDaW7-G0DW0AA89G6HY='),
      ],
      showIndicator: false,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        imageCarousel,
        SizedBox(height: 10),
        Container(
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            color: Colors.purple,
            gradient: new LinearGradient(
              colors: [Colors.blue, Colors.redAccent],
            ),
            boxShadow: [
              new BoxShadow(
                color: Color(0xff514a9d),
                offset: new Offset(20.0, 30.0),
                blurRadius: 40.0,
              )
            ],
          ),
          height: 250,
          width: 350,
          child: new InkWell(
            onTap: pickImage,
            child: Card(
              elevation: 7.0,
              child: Container(
                padding: EdgeInsets.only(
                    left: 12.0, top: 180.0, right: 2.0, bottom: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/MLaccident.jpg"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                // child: Card1(),
              ),
            ),
          ),
        ),
        _loading
            ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
            : Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null ? Container() : Image.file(_image),
              SizedBox(
                height: 20,
              ),
              _outputs != null
                  ? "${_outputs[0]["label"]}" != "invalid image"
                  ? RaisedButton(
                  onPressed: () {
                    sendImg(_image);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScratchCard()));
                  },
                  child: Text(
                    "${_outputs[0]["label"]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()
                        ..color = Colors.white,
                    ),
                  ))
                  : Text(
                "${_outputs[0]["label"]}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()
                    ..color = Colors.white,
                ),
              )
                  : Container(),
            ],
          ),
        ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: pickImage,
//        child: Icon(Icons.image),
//      ),
      ],
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant_accident.tflite",
      labels: "assets/labels_accidents.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
