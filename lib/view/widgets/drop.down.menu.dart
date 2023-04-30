import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class DropdownMenuAlter extends StatefulWidget {
  const DropdownMenuAlter(
      {super.key,
      required this.listOfItems,
      required this.returnValue,
      required this.refreshData,
      required this.selectedItem});
  final int selectedItem;
  final List<String> listOfItems;
  final Function refreshData;
  final Function(int) returnValue;

  @override
  State<DropdownMenuAlter> createState() => _DropdownMenuAlterState();
}

class _DropdownMenuAlterState extends State<DropdownMenuAlter> {
  String? selectedItemMenu;
  List<DropdownMenuItem> items = [];
  @override
  void initState() {
    super.initState();
    selectedItemMenu = widget.listOfItems[widget.selectedItem - 1];
    widget.returnValue(widget.selectedItem);
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
      onChanged: (item) {
        setState(() {
          selectedItemMenu = item;
        });
        widget.returnValue(widget.listOfItems.indexOf(item) + 1);
        widget.refreshData();
      },
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      iconEnabledColor: GlobalColors.mainColor,
      isExpanded: true,
    );
  }
}
