import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper(
    {super.key, 
    required this.movies
    }
  );
  
  @override
  Widget build(BuildContext context) {
    //se guarda el variable las medidas del dispositivo
    final size=MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount:movies.length,
        // manera de mostrar las cartas
        layout: SwiperLayout.STACK,
        // ancho y alto en porcentajes
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.9,
        itemBuilder: (context,int i){

          final movie = movies[i];
          movie.heroId = 'swiper-${movie.id}';
          
          return GestureDetector(
            onTap: ()=>Navigator.pushNamed(
              context, 'details',arguments: movie),
            child: Column(
                  children: [
                    Text(movie.title,style:TextStyle(
                      fontSize:15,fontWeight: FontWeight.bold) 
                      ),
                    SizedBox(height: 5),
                    Hero(
                      tag: movie.heroId!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          placeholder: AssetImage('image/no-image.jpg'),
                          //carga url que trae del metodo
                          image: NetworkImage(movie.fullPosterImg),
                          fit: BoxFit.cover,
                                      ),
                                    ),
                    ),
              ],
              
            ),
          );
        }
      )
    );
  }
}