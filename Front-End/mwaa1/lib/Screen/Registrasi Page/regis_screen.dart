import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/Screen/control_page.dart';
import 'package:mwaa1/widget/theme.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  String? selectedValue;
  String? pilihanValue;
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/MWA.png",
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jenis Udang',
                style: outfit15normal.copyWith(fontWeight: FontWeight.bold)
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
                style: outfit15normal.copyWith(fontWeight: FontWeight.bold)
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: Colors.orange[300],
                  ),
                  Text(
                    "Pengaturan Sudah Sesuai",
                    style: montserrat17normal.copyWith(fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(height: 50), //buat checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ControlPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: bluelogin),
                    child: Text("Selanjutnya",
                        style: montserrat17normal.copyWith(
                            color: Colors.white,
                            fontSize: 20)),
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
