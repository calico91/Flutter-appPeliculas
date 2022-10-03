import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CardCasting extends StatelessWidget {

  final int movieId;

  const CardCasting(this.movieId);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _, AsyncSnapshot<List<Cast>> snapshot){

        if(!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom:30),
          width: double.infinity,
          height: 180,
          //construir listas 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (_, int i)=> _CardCast(cast[i])
          )
    );
      },
      );
  }
}

class _CardCast extends StatelessWidget {

  final Cast actor;

  const _CardCast(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          //bordes redondos
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('image/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140, 
              width: 100,
              //toma todo el ancho y alto del contenedor
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height:4,),
          Text(actor.originalName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,)
        ]
      ),
    );
  }
}