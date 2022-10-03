import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {

    //se guarda en variable el resultado de Movie
    final Movie movie = ModalRoute.of(
      context)!.settings.arguments as Movie;

    print(movie.fullBackDropPath);

    return Scaffold(
      // similar al appbar, pero tiene movimiento 
      body:CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          //lista de widgets para agregar al body
          SliverList(
            delegate:SliverChildListDelegate([
              _PosteryTitulo(movie),
              _vistaGeneral(movie),
              _vistaGeneral(movie),
              _vistaGeneral(movie),
              CardCasting(movie.id),
            ]
            ) )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(
   this.movie);



  @override
  Widget build(BuildContext context) {
    // tiene comportamiento con el scroll, similar al appbar
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:EdgeInsets.only(bottom: 15),
        centerTitle: true,
        title: Text(movie.title,style: TextStyle(color:Colors.orange)),
        background: FadeInImage(
          placeholder: AssetImage('image/loading.gif'),
          image: NetworkImage(movie.fullBackDropPath),
          //se expande a todo el contenedor
          fit: BoxFit.cover,
        ),
        ),
    );
  }
}

class _PosteryTitulo extends StatelessWidget {
  
final Movie movie;

  const _PosteryTitulo(this.movie);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final TextTheme textThemeV = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          //borde circular
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('image/no-image.jpg'),
                image: NetworkImage(movie.fullBackDropPath),
                //width: size.width*0.3,
                height: size.height*0.1,
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            width:size.width*0.4,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, 
                style: textThemeV.headline5,
                 //separa en dos linea si el titulo es largo
                maxLines: 2,
                //si el texto se sale, completa con ...
                overflow: TextOverflow.ellipsis,
                ),
               
          
                Text(movie.originalTitle, 
                style: textThemeV.subtitle1,
                //si el texto se sale, completa con ...
                overflow: TextOverflow.ellipsis),
          
                Row(
                  children: [
                    Icon(Icons.star_border_outlined, size:15, color: Colors.grey[600],),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(), style:textThemeV.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _vistaGeneral extends StatelessWidget {

  final Movie movie;

  const _vistaGeneral(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:30,vertical: 10),
      child: Text(movie.overview,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.subtitle1),
    );
  }
}