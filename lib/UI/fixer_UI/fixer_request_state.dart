import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

class FixerRequest extends StatefulWidget {
  const FixerRequest({Key? key}) : super(key: key);

  @override
  FixerRequestState createState() => FixerRequestState();
}

class FixerRequestState extends State<FixerRequest> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> imageList = [
    'assets/images/fixR1.jpg',
    'assets/images/fixR2.jpg',
  ];

  Widget slideshow() {
    //Slideshow con mocks
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
        items: imageList
            .map((image) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                        width: 1050,
                        height: 350,
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back",
                            style: TextStyle(color: Color(0xFFA5A6F6))))),
                Padding(
                  padding: EdgeInsets.only(left: 75),
                  child: Text("Request",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          slideshow(),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Mi computador no funciona",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Autor: Diego",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Dirección: Caribe Azul",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                        "Hola, ayer estaba jugando DBD en mi PC y derrepente se apagó y no volvió a encender, me dicen que es la RAM pero no tengo la mas minima idea de que es eso, necesito asistencia!",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF666666)))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FixerSetOffer()));
                      },
                      child: Text("Check Offer",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    )),
                //0xFF666666
              ],
            ),
          ),
          MainButtons(
            wrenchVisibility: false,
          )
        ],
      ),
    )));
  }
}
