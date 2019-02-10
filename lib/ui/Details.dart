import 'package:flutter/material.dart';

class Details extends StatefulWidget {

  final String header;
  final int id;

  Details({Key key, this.header, this.id}) : super(key: key);

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



    );
  }
}
