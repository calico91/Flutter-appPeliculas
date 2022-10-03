import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  final String? nombre;
  final List<Movie> movies;
  final Function onNextPage;

  const MovieSlider(
    {super.key, 
    required this.movies, 
    required this.onNextPage,
    this.nombre,}
    );

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollControler = new ScrollController();

  @override
  //se ejecuta el codigo la primera vez que el widget es construido
  void initState() {
    super.initState();

    scrollControler.addListener(() {
      if (scrollControler.position.pixels >=
          scrollControler.position.maxScrollExtent - 500) {
            widget.onNextPage();
      }
    });
  }

  @override
  // widget va ser destruido
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // toma el ancho total del dispositivo
      height: 260,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // texto al inicio
          children: [
            if (this.widget.nombre != null)
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.nombre!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            // expande hacia la orientacion que se de
            Expanded(
                child: ListView.builder(
                    controller: scrollControler,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movies.length,
                    itemBuilder: (context, int i) =>
                        _moviePoster(widget.movies[i], '${i}-${widget.movies[i].id}')))
          ]),
    );
  }
}

class _moviePoster extends StatelessWidget {
  final Movie movies;
  final String heroId;

  const _moviePoster(this.movies, this.heroId);

  @override
  Widget build(BuildContext context) {

    movies.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(children: [
        GestureDetector(
          //redirecciona a otro screen
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: movies),
          child: Hero(
            tag:movies.heroId!,
            child: ClipRRect(
              // aspecto rectangular redondo a imagenes
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('image/no-image.jpg'),
                  image: NetworkImage(movies.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(movies.title,
            maxLines: 2, // genera dos lineas para el texto
            overflow:
                TextOverflow.ellipsis, // le pone ... cuando es muy extenso
            textAlign: TextAlign.center)
      ]),
    );
  }
}
