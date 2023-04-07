import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/global.colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.function,
  });
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: function,
        child: Container(
          margin: const EdgeInsets.all(15),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              )
            ],
          ),
          child: Icon(
            CupertinoIcons.text_justify,
            color: GlobalColors.mainColor,
          ),
        ),
      ),
    );
  }
}
