import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class ComputerInput extends StatefulWidget {
  const ComputerInput({
    super.key,
    required this.computerNumber,
    required this.isNotEnabled,
    required this.selectedReturnValue,
  });
  final int computerNumber;
  final bool isNotEnabled;
  final Function(int) selectedReturnValue;
  @override
  State<ComputerInput> createState() => _ComputerInputState();
}

class _ComputerInputState extends State<ComputerInput> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: CupertinoButton(
            color: isSelected ? Colors.blue : GlobalColors.mainColor,
            padding: EdgeInsets.zero,
            onPressed: widget.isNotEnabled
                ? null
                : () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                    widget.selectedReturnValue(widget.computerNumber);
                  },
            alignment: Alignment.center,
            disabledColor: const Color.fromARGB(255, 204, 204, 204),
            child: const Icon(CupertinoIcons.desktopcomputer),
          ),
        ),
        Text(
          widget.computerNumber.toString(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    );
  }
}

class ComputerInputNoFunction extends StatefulWidget {
  const ComputerInputNoFunction(
      {super.key, required this.color, required this.text});
  final int color;
  final String text;
  @override
  State<ComputerInputNoFunction> createState() =>
      _ComputerInputNoFunctionState();
}

class _ComputerInputNoFunctionState extends State<ComputerInputNoFunction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CupertinoButton(
            color: widget.color == 1
                ? Colors.blue
                : widget.color == 2
                    ? GlobalColors.mainColor
                    : Colors.black,
            padding: EdgeInsets.zero,
            disabledColor: const Color.fromARGB(255, 204, 204, 204),
            onPressed: widget.color == 3 ? null : () {},
            alignment: Alignment.center,
            child: const Icon(
              CupertinoIcons.desktopcomputer,
              size: 15,
            ),
          ),
        ),
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    );
  }
}
