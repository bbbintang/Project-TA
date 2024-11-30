import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/Home%20Page/home_page.dart';
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
                        isChecked = value?? false;
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
            const SizedBox(height: 50), //buat checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika if-else di sini
                      if (selectedValue != null &&
                          pilihanValue != null &&
                          isChecked) {
                        String S = ""; // Nilai Suhu 
                        String P = ""; // Nilai Ph
                        String T = ""; // Nilai TDS
                        String D = ""; // Nilai DO
    

                        // Logika if-else berdasarkan pilihan
                        if (selectedValue == "Vaname" &&
                            pilihanValue == "Tradisional") {
                          S = "20.20";
                          T = "11.1";
                          P = "30.3";
                          D = "4.14";
                        } else if (selectedValue == "Vaname" &&
                            pilihanValue == "Intensif") {
                          S = "2.20";
                          T = "15.0";
                          P = "30.8";
                          D = "4.44";
                        } else if (selectedValue == "Vaname" &&
                            pilihanValue == "Super Intensif") {
                          S = "20.28";
                          T = "11.20";
                          P = "35.2";
                          D = "55.5";
                        } else if (selectedValue == "Udang Galah" &&
                            pilihanValue == "Tradisional") {
                          S = "20.20";
                          T = "11.1";
                          P = "30.3";
                          D = "4.14";
                        } else if (selectedValue == "Udang Galah" &&
                            pilihanValue == "Intensif") {
                          S = "20";
                          T = "11";
                          P = "3";
                          D = "4";
                        } else if (selectedValue == "Udang Galah" &&
                            pilihanValue == "Super Intensif") {
                          S = "25";
                          T = "15";
                          P = "33";
                          D = "40";
                        } else if (selectedValue == "Udang Windu" &&
                            pilihanValue == "Tradisional") {
                          S = "20.20";
                          T = "11.1";
                          P = "30.3";
                          D = "4.14";
                        } else if (selectedValue == "Udang Windu" &&
                            pilihanValue == "Intensif") {
                          S = "27";
                          T = "12";
                          P = "39";
                          D = "14";
                        } else if (selectedValue == "Udang Windu" &&
                            pilihanValue == "Super Intensif") {
                          S = "50";
                          T = "30";
                          P = "20";
                          D = "50";
                        } else {
                          S = "Tak ada Nilai";
                          D = "Tak ada Nilai";
                          T = "Tak ada Nilai";
                          P = "Tak ada Nilai";
                          }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                Suhu: S,
                                pH : P,
                                TDS : T,
                                DO : D,
                                Udang : selectedValue!,
                                Tambak : pilihanValue!,
                              ),
                            ),
                          );
                          } else {
                        // Tampilkan pesan jika data belum lengkap
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Peringatan"),
                            content: const Text(
                                "Pastikan semua pilihan telah diisi dan ceklis pengaturan sesuai."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      }
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
