import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwaa1/widget/theme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text("Batas Ukur Parameter Air", style: outfit20bold.copyWith(color: darkblue),)),
          const SizedBox(height: 10,),
          Text("Suhu", style: outfit17normal.copyWith(color: darkblue),),
          const CustomTextField(text1: "Min :", text2: "Max :",),
          const SizedBox(height: 10,),
          Text("PH", style: outfit17normal.copyWith(color: darkblue),),
          const CustomTextField(text1: "Min :", text2: "Max :",),
          const SizedBox(height: 10,),
          Text("Oksigen", style: outfit17normal.copyWith(color: darkblue),),
          const CustomTextField(text1: "Min :", text2: "Max :",),
          const SizedBox(height: 10,),
          Text("TDS", style: outfit17normal.copyWith(color: darkblue),),
          const CustomTextField(text1: "Min :", text2: "Max :",),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomTextField({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: outfit17normal.copyWith(color: darkblue),
          ),
          const SizedBox(
            width: 50,
            height: 17,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                vertical: 10,
              )),
            ),
          ),
          const SizedBox(width: 30,),
          Text(
            text2,
            style: outfit17normal.copyWith(color: darkblue),
          ),
          const SizedBox(
            width: 50,
            height: 17,
            child: TextField(
              showCursor: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                vertical: 10,
              )),
            ),
          )
        ],
      ),
    );
  }
}
