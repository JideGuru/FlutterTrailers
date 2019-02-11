import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trailers/util/Config.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {

  final String header;
  final String img;
  final int id;

  Details({Key key, this.header, this.img, this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  var isLoading = false;
  Map allData;
  List data;
  Future getTrailers() async {
    setState(() {
      isLoading = true;
    });
    String url = "${Config.baseUrl}movie/${widget.id}/videos${Config.apiKey}";

    http.Response response = await http.get(url);
    allData = jsonDecode(response.body);
//    data = allData["results"];

    data = allData['results'];
    setState(() {
      isLoading = false;
    });
    debugPrint(data.toString());
  }

  @override
  void initState() {
    super.initState();
    getTrailers();
  }


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

      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
        ),
      ) :Container(
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
                width: 400.0,
                fit: BoxFit.cover,
              ),
              height: 200.0,
              width: 400.0,
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                "${widget.header}",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                itemBuilder: (BuildContext context, int position){
                  String img = "${Config.ytImg}${data[position]["key"]}/0.jpg";
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Image.network(img),
                        ),
                      ],
                    )
                  );
                },
                itemCount: data == null ? 0 : data.length,
              ),
            )
          ],
        ),
      ),


    );
  }
}
