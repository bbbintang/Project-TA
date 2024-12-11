import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomBulan extends StatelessWidget {
  final String bulanke;
  const CustomBulan({
    super.key,
    required this.bulanke,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white54
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              bulanke,
              style: poppin15normal.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  letterSpacing: 1.0),
            )
          ],
        ),
      ),
    );
  }
}


class CustomHistory extends StatelessWidget {
  final String tanggalke;
  final String jamke;
  final double nilaiSuhu;
  final double nilaiPH;
  final double nilaiTDS;
  final double nilaiDO;

  const CustomHistory(
      {super.key,
      required this.tanggalke,
      required this.jamke,
      required this.nilaiSuhu,
      required this.nilaiPH,
      required this.nilaiTDS,
      required this.nilaiDO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                tanggalke,
                style: poppin15normal.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                width: 180,
              ),
              Text(
                jamke,
                style: poppin15normal.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Suhu : ",
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    nilaiSuhu.toString(),
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "PH   : ",
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    nilaiPH.toString(),
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "TDS  : ",
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    nilaiTDS.toString(),
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "DO   : ",
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    nilaiDO.toString(),
                    style: poppin15normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Divider(color: Colors.black45,),
        ),
      ],
    );
  }
}

