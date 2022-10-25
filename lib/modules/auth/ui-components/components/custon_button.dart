import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {

  final void Function() action;
  final String buttonName;
  const ButtonAction({Key? key, required this.action, required this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 45,
      child: ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(109, 71, 186, 1))
        ),
        child: Text(
          buttonName,
          softWrap: true,
          style: TextStyle(
            color: Color.fromRGBO(254, 247, 255, 1)
          ),
        )
      ),
    );
  }
}