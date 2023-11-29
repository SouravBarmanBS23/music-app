import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloudButton extends StatefulWidget {
  const CloudButton(
      {super.key,
      required this.cloudName,
      required this.cloudImage,
      required this.onButtonTap});
  final String cloudName;
  final String cloudImage;
  final Function onButtonTap;

  @override
  State<CloudButton> createState() => _CloudButtonState();
}

class _CloudButtonState extends State<CloudButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onButtonTap.call();
      },
      child: Container(
        margin: EdgeInsets.only(top: 0.02.sh),
        height: 60,
        width: 0.6.sw,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.cloudName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(
                'images/cloud/${widget.cloudImage}',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
