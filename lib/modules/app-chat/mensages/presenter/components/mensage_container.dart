import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MensageContainer extends StatelessWidget {

  final String mensage;
  final Color containerColor;

  const MensageContainer({Key? key, required this.mensage, required this.containerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(        
        padding: EdgeInsets.only(left: 5,right: 5),
        constraints: BoxConstraints(maxWidth: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
          color: containerColor
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 7,bottom: 7),
          child: Text(
            mensage,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Color.fromRGBO(254, 247, 255, 1),
                fontSize: 14,
              ),
            )  
          )
        ),    
      ),
    );
  }
}