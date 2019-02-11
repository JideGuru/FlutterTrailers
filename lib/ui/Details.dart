import 'package:flutter/material.dart';

class Details extends StatefulWidget {

  final String header;
  final String img;
  final int id;

  Details({Key key, this.header, this.img, this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Background Color
      backgroundColor: Colors.white,


      appBar: AppBar(
        title: Text(
          widget.header,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
        child: Column(
          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Image.network(
//                  widget.img,
//                  height: 250.0,
//                  fit: BoxFit.cover,
//                ),
//              ],
//            ),
            Container(
              child: Image.network(
                widget.img,
                height: 200.0,
                width: 370.0,
                fit: BoxFit.cover,
              ),
              height: 200.0,
              width: 370.0,
            ),
          ],
        ),
      ),


    );
  }
}
