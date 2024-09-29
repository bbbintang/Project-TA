import 'package:flutter/material.dart';
import 'package:mwaa1/widget/menu_item.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:popover/popover.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => MenuItem(),
        width: 280,
        height: 300,
        direction: PopoverDirection.bottom
      ),
        child: Icon(Icons.more_horiz, color: darkblue,),
      );
  }
}