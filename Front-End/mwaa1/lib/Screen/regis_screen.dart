import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  String? selectedValue;
  String? pilihanValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "MWA.png",
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jenis Udang',
                style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String?>(
                value: selectedValue,
                items: ["Vaname", "Udang Galah", "Udang Windu"]
                    .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                isExpanded: true,
                underline: const SizedBox(),
                hint: Text("Pilih Jenis Udang"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jenis Tambak',
                style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String?>(
                value: pilihanValue,
                items: [
                  "Tradisional",
                  "Semi Intensif",
                  "Intensif",
                  "Super Intensif"
                ]
                    .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onChanged: (nilai) {
                  setState(() {
                    pilihanValue = nilai;
                  });
                },
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Pilih Jenis Tambak"),
              ),
            ),
            SizedBox(height: 100), //buat checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFF0B6EFE),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    "Selanjutnya",
                    style: GoogleFonts.outfit(
                      fontSize: 20, 
                      color: Colors.white
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
