import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PromoCarousel extends StatelessWidget {
  const PromoCarousel({Key? key}) : super(key: key);

  final List<String> promoImages = const [
    'https://images.unsplash.com/photo-1532339142463-fd0a8979791a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJpcHxlbnwwfHwwfHx8MA%3D%3D',
    'https://media.istockphoto.com/id/497038029/photo/travel.webp?a=1&b=1&s=612x612&w=0&k=20&c=wx5Vw7bVFv4w4tk5Qm00OtK3kUrxAoVDuZV5mt47G7E=',
    'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHRyaXB8ZW58MHx8MHx8fDA%3D',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: promoImages.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(item),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}