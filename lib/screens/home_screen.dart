import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // va al arbol de widgets trae la instancia de movieproviders
    final moviesProvider = Provider.of<MoviesProvider>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'buscar peliculas',
            onPressed: ()=> showSearch(context: context, 
              delegate: MovieSearchDelegate())
          ),
        ]
      ),
      //hace scroll si el contenido sobrepasa la capacidad de la pantalla
      body:SingleChildScrollView(
        child: Column(
          children: [
            //tarjetas principal
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CardSwiper(movies: moviesProvider.onDisplayMovies)
              ),
            // slider de peliculas
            MovieSlider(nombre:'Populares',
            movies: moviesProvider.PopularMovies,
            onNextPage:() =>  moviesProvider.getPopularMovies()
            ),
            MovieSlider(nombre:'Buenas',
            movies: moviesProvider.topRatedMovies,
            onNextPage:() =>  moviesProvider.getTopRatedMovies()
            )
          ],
        ),
      )
    );
  }
}