import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class DropdownMenuAlter extends StatefulWidget {
  const DropdownMenuAlter({super.key, required this.listOfItems});
  final List<String> listOfItems;
  @override
  State<DropdownMenuAlter> createState() => _DropdownMenuAlterState();
}

class _DropdownMenuAlterState extends State<DropdownMenuAlter> {
  String? selectedItemMenu;
  List<DropdownMenuItem> items = [];
  @override
  void initState() {
    super.initState();
    selectedItemMenu = widget.listOfItems[0];
    for (var i = 0; i < widget.listOfItems.length; i++) {
      items.add(
        DropdownMenuItem(
          value: widget.listOfItems[i],
          child: Center(
            child: Text(
              widget.listOfItems[i],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      value: selectedItemMenu,
      onChanged: (item) => setState(
        () {
          selectedItemMenu = item;
        },
      ),
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      iconEnabledColor: GlobalColors.mainColor,
      isExpanded: true,
    );
  }
}
