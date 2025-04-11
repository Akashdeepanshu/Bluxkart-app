import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopbyGender extends StatelessWidget{
  const ShopbyGender({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/girlLogo.main-removebg-preview.png",
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Text(
                            "Shop Women",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            onTap: (){},
          ),
          5.widthBox,
          InkWell(
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/1712550077043-removebg-preview.png",
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Text(
                            "Shop Men",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            onTap: (){},
          ),
        ],
      ),
    );

  }

}