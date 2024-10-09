import 'package:flutter/material.dart';
import 'package:mwaa1/widget/menubutton_history.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:popover/popover.dart';

class ButtonHistorypage extends StatelessWidget {
  const ButtonHistorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => MenubuttonHistory(),
        width: 280,
        height: 300,
        direction: PopoverDirection.bottom
      ),
        child: Icon(Icons.menu, color: grey, size: 30,),
      );
  }
}