import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trailers/podo/Result.dart';
import 'package:trailers/ui/Details.dart';
import 'package:trailers/util/Config.dart';
import 'package:transparent_image/transparent_image.dart';



class Home extends StatefulWidget {
  final String header;

  Home({Key key, this.header}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  PageController _pageController;
  int _page = 0;
// Method to get now playing movies from the backend
  Future<List<Result>> getPopularMovies(String burl) async {

    var httpClient = new HttpClient();
    try {
      // Make the call
      var request = await httpClient.getUrl(Uri.parse(burl+Config.apiKey));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        // Decode the json response
        var data = jsonDecode(jsonResponse);
        // Get the result list
        List result = data["results"];
        // Get the Movie list
        List<Result> popularList = createPopularMovieList(result);
        print("RES: ${result[0]["title"]}");
        // Print the results.
        return popularList;
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  // Method to parse information from the retrieved data
  List<Result> createPopularMovieList(List data) {
    List<Result> list = new List();
    for (int i = 0; i < data.length; i++) {
      var vote_count = data[i]["vote_count"];
      var id = data[i]["id"];
      bool video = data[i]["video"];
      var vote_average = data[i]["vote_average"];
      String title = data[i]["title"];
      double popularity = data[i][" popularity"];
      String poster_path = data[i]["poster_path"];
      String original_language = data[i]["original_language"];
      String original_title = data[i]["original_title"];
      String backdrop_path = data[i]["backdrop_path"];
      String overview = data[i]["overview"];
      bool adult = data[i]["adult"];
      String release_date = data[i]["release_date"];

      Result movie = new Result(
          vote_count,
          id,
          video,
          vote_average,
          title,
          popularity,
          poster_path,
          original_language,
          original_title,
          backdrop_path,
          adult,
          overview,
          release_date);
      list.add(movie);
    }
    return list;
  }


  // create a card layout for the popular movies
  List<Widget> createPopularMovieCardItem(
      List<Result> movies, BuildContext context) {
    // Children list for the list.
    List<Widget> listElementWidgetList = new List<Widget>();
    if (movies != null) {
      var lengthOfList = movies.length;
      for (int i = 0; i < lengthOfList; i++) {
        Result movie = movies[i];
        // Image URL
        var imageURL = "https://image.tmdb.org/t/p/w500/" + movie.poster_path;
        // List item created with an image of the poster
        var listItem = new GridTile(
            footer: new GridTileBar(
              backgroundColor: Colors.black45,
              title: new Text(movie.title),
            ),
            child: new GestureDetector(
              onTap: () {
                if (movie.id > 0) {

                  var router = new MaterialPageRoute(
                      builder: (BuildContext context){
                        return Details(header: widget.header, id: movie.id);
                      }
                  );

                  Navigator.of(context).push(router);
                }
              },
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageURL,
                fit: BoxFit.cover,
              ),
            ));
        listElementWidgetList.add(listItem);
      }
    }
    return listElementWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Background Color
      backgroundColor: Colors.white,

      //AppBar
      appBar: AppBar(
        title: Text(
          widget.header,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint("1PRESSED!!!"),
            color: Colors.white,
          )
        ],
      ),


      //Body
      body: PageView(
        children: <Widget>[

          //Home
          Offstage(
            offstage: _page != 0,
            child: new TickerMode(
              enabled: _page == 0,
              child: new FutureBuilder(
                  future: getPopularMovies(Config.popularUrl),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return new Container(
                        child: new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return new CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: new SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children:
                            createPopularMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),

          //Browse
          Offstage(
            offstage: _page != 1,
            child: new TickerMode(
              enabled: _page == 1,
              child: new FutureBuilder(
                  future: getPopularMovies(Config.topUrl),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return new Container(
                        child: new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return new CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: new SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children:
                            createPopularMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),


          //Downloads
          Offstage(
              offstage: _page != 2,
              child: TickerMode(
                  enabled: _page == 2,
                  child: Text("Downloads will appear here")
              )
          ),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),

      //BottomNav
      bottomNavigationBar: BottomNavigationBar(items: [

        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: Colors.red,
              ),
            )
        ),

        BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
              color: Colors.red,),
            title: Text(
              "Top Rated",
              style: TextStyle(
                color: Colors.red,
              ),
            )
        ),

        BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_downward,
              color: Colors.red,),
            title: Text(
              "Downloads",
              style: TextStyle(
                color: Colors.red,
              ),
            )
        ),

      ],
        onTap: navigationTapped,
        currentIndex: _page,
//        onTap: (int i)=>debugPrint("Tap $i"),
      ),
    );
  }


  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
//    getPopularMovies(Config.popularUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }


}
