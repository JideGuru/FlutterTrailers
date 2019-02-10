import 'package:trailers/podo/Genre.dart';
import 'package:trailers/podo/ProductionCompany.dart';
import 'package:trailers/podo/ProductionCountry.dart';
import 'package:trailers/podo/SpokenLanguage.dart';

class MovieDetails{
  bool adult;
  String backdrop_path;
  Object belongs_to_collection;
  int budget;
  List<Genre> genres;
  Object homepage;
  int id;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<ProductionCompany> production_companies;
  List<ProductionCountry> production_countries;
  String release_date;
  int revenue;
  int runtime;
  List<SpokenLanguage> spoken_languages;
  String status;
  String tagline;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  MovieDetails(this.adult, this.backdrop_path, this.belongs_to_collection,
      this.budget, this.genres, this.homepage, this.id, this.imdb_id,
      this.original_language, this.original_title, this.overview,
      this.popularity, this.poster_path, this.production_companies,
      this.production_countries, this.release_date, this.revenue, this.runtime,
      this.spoken_languages, this.status, this.tagline, this.title, this.video,
      this.vote_average, this.vote_count);


}