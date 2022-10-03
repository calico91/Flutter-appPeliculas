
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/top_rated.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'aaf06301075d53c4a875e0072bb92b9c';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> PopularMovies   = [];
  List<Movie> topRatedMovies  = [];

  Map<int, List<Cast>> moviesCast = {};

  int _page=0;
  

  MoviesProvider(){
    print('Movies Provider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    getTopRatedMovies();
  
  }


  Future<String> _getJsonData ( String endpoint,[int page =1]) async{
    //crea la peticion http
    var url =
    Uri.https(_baseUrl, endpoint, {
      'api_key':_apiKey,
      'language':_lenguage,
      'page':'$page'
      });

    // obtiene la peticion, lo devuelve en string
    final response = await http.get(url);
    // informacion de la consulta se convierte en un mapa dinamico
    return response.body;
  }

  getOnDisplayMovies()async{
    // trae el resultado de la peticion 
   final jsonData = await _getJsonData('3/movie/now_playing');

    // informacion de la consulta se convierte en un mapa dinamico
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    //guarda los resultados de la consulta 
    onDisplayMovies = nowPlayingResponse.results;

    //redibuja cuando hay cambios en la data
    notifyListeners();
  }

    getPopularMovies()async{
  
    _page++;
    // se crea la peticion http
    final jsonData = await _getJsonData('3/movie/popular',_page);
    // informacion de la consulta se convierte en un mapa dinamico
    final popular = Popular.fromJson(jsonData);

    //guarda los resultados de la consulta 
    PopularMovies = [... PopularMovies, ...popular.results];

    //redibuja cuando hay cambios en la data
    notifyListeners();
  }

  getTopRatedMovies()async{

    // se crea la peticion http
    final jsonData = await _getJsonData('3/movie/top_rated',_page);
  
    // informacion de la consulta se convierte en un mapa dinamico
    final topRated = TopRated.fromJson(jsonData);

    //guarda los resultados de la consulta 
    topRatedMovies = [... topRatedMovies, ...topRated.results];

    //redibuja cuando hay cambios en la data
    notifyListeners();
  }

  Future <List<Cast>> getMovieCast(int movieId) async {

    // si ya se ha hecho la peticion una vez, muestra el mapa
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = Credits.fromJson(jsonData);

    moviesCast[movieId]= creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies (String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key':_apiKey,
      'language':_lenguage,
      'query':query
      });

    final response = await http.get(url);
    final searchMovie = SearchMovie.fromJson(response.body);
    
    return searchMovie.results;
  }

}