import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'Mlverify.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TabScreen1();
}

class _TabScreen1 extends State<Page1> {
  @override
  int currentPage = 0;
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

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new Scaffold(
        backgroundColor: Colors.white70,
        body: new ListView(
            padding:
                EdgeInsets.only(left: 2.0, top: 10.0, right: 2.0, bottom: 10.0),
            children: <Widget>[
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
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Ml()));
                  },
                  child: Card(
                    elevation: 7.0,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12.0, top: 180.0, right: 2.0, bottom: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/sepmcard1.jpg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      // child: Card1(),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
