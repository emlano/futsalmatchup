import 'package:flutter/material.dart';
import 'package:frontend/views/home/Description.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/views/home/Nearby.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

  List<Description > description=[
    Description("CRFC","Dehiwala", "3000/= per hour"),
    Description("UniSports","Kirulapone", "3500/= per hour"),
    Description("Turf", "wellawatta", "4000/= per hour"),
  ];
  List<Nearby> nearby=[
    Nearby("UniSports", "Kirulapone", "5000/= Per hour"),
    Nearby("Turf","Wellawatta", "6000/= Per hour"),
    Nearby("CRFC", "Dehiwala", "4500/= Per hour")
  ];

  Widget nearbyTemplate(Nearby items){
    return Container(
      height: 300,
      width: 225,
      child: Card(
        elevation: 4.0,
        color: Colors.grey[450],
        child: Column(
          children:[ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset("assets/images/Futsal2.jpg",
            fit: BoxFit.cover,
            height: 129,
            width: 200 ,),
        ),
            Text(items.courtName1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(items.courtLocation1,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),),
            Text(items.price1,
              style:TextStyle(
                fontSize: 14,
              ) ,),
        ]
        ),
      ),
    );

  }
  Widget descriptionTemplate(Description item){
    return Container(
      height: 300,
      width: 500,
      child: Card(
        elevation: 4.0,
         color: Colors.grey[450],
         child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/images/Futsal1.jpg",
                fit: BoxFit.cover,
                height: 129,
                width: 275 ,),
              ),
                Text(item.courtname,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
                Text(item.location,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),),
              Text(item.price,
                style:TextStyle(
                  fontSize: 14,
                ) ,),
            ],
          ),

      ),
    );

  }
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),

            Container(
                padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                child: Text("Welcome back",
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 15,
                  ),)),
            Container(
              padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
              child: Text("Rimaz Abdul",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "inter",
                  fontSize: 15,
                ),
              ),

            ),
            SizedBox(height: 22),
            // Container(
            //   padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: Container(
            //       child: IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.account_circle),
            //         iconSize: 40,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: Text("Discounts",
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
               ),
              items: description.map((item) => descriptionTemplate(item))
                      .toList(),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Nearby Futsal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: "inter",
                ),
              ),
            ),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          items: nearby.map((items) => nearbyTemplate(items))
              .toList(),
            // TextButton(
            //     onPressed: (){},
            //     child: Text(". . .",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     )))
        ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: Text("Teams",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 10),


            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[600],
              ),
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(7, 7, 11, 7),
              // color: Colors.grey[700],
              child: Text("Ahmed has invited You for a match",
              style: TextStyle(
                color: Colors.white70,
              ),),

            )
          ],
        ),

    );
  }
}


// Card(
//   elevation: 4.0,
//   margin: EdgeInsets.all(10),
//   child: Column(
//     children: [
//       Image.asset("assets/images/Futsal1.jpg",
//         fit: BoxFit.cover),
//
//     ],
//   ),
// ),
