import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {

  final TextEditingController controller;
  final void Function()? onPressedFunction;

  const BottomWidget({Key? key, required this.controller, required this.onPressedFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(bottom: 5,left: 5),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: controller,
                  cursorColor: Color.fromRGBO(75, 68, 83, 1),  
                  decoration: InputDecoration( 
                    focusColor: Color.fromRGBO(75, 68, 83, 1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(75, 68, 83, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(75, 68, 83, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(109, 71, 186, 1))
                  ),
                  onPressed: onPressedFunction, 
                  child: Icon(Icons.send,)
                ),
              )
            )
          ],
        ),
      )
    );
  }
}