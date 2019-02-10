import 'package:trailers/podo/Result.dart';

class Response {
  int page;
  int total_results;
  int total_pages;
  List<Result> results;

  Response(this.page, this.total_results, this.total_pages, this.results);

}