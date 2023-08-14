import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/size_config.dart';

class CustomButton extends StatelessWidget {
  Function() onTap;
  final String title;
  CustomButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
        decoration: BoxDecoration(),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkBrownColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            title,
            style: kEncodeSansRagular.copyWith(
              color: Colors.blue,
              // fontSize: SizeConfig.blockSizeHorizontal * 3.5,
            ),
          ),
        ),
      ),
    );
  }
}
