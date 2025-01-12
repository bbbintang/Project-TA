import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/3_Home%20Page/menu_item.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:popover/popover.dart';

class ButtonHomePage extends StatelessWidget {
  const ButtonHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => MenuItem(),
        width: 335,
        height: 500,
        direction: PopoverDirection.bottom
      ),
        child: Icon(Icons.more_horiz, color: darkblue,),
      );
  }
}