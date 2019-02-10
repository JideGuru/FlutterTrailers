class Result {
  var vote_count;
  var id;
  bool video;
  var vote_average;
  String title;
  var popularity;
  String poster_path;
  String original_language;
  String original_title;
//  List<int> genre_ids;
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  Result(this.vote_count, this.id, this.video, this.vote_average, this.title,
      this.popularity, this.poster_path, this.original_language,
      this.original_title, /*this.genre_ids,*/ this.backdrop_path, this.adult,
      this.overview, this.release_date);
  
}