import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/menubutton_history.dart';
import 'package:popover/popover.dart';

class ButtonHistorypage extends StatelessWidget {
  const ButtonHistorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => MenubuttonHistory(),
        width: 300,
        height: 370,
        direction: PopoverDirection.bottom
      ),
        child: CircleAvatar(child: Icon(Icons.download_rounded, color: Colors.grey[600], size: 30,)),
      );
  }
}