import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mwaa1/Screen/control_page.dart';
import 'package:mwaa1/widget/theme.dart';

class RegisScreen extends StatefulWidget {
  final String displayName; // Data dari Welcome Page
  final String email; // Data dari Welcome Page
  final String photoUrl; // Data dari Welcome Page

  const RegisScreen({
    super.key,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  String? selectedValue; // Jenis Udang
  String? pilihanValue; // Jenis Tambak
  var isChecked = false;

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('displayName', widget.displayName); // Nama pengguna
    await prefs.setString('email', widget.email); // Email pengguna
    await prefs.setString('photoUrl', widget.photoUrl); // Foto pengguna
    await prefs.setString('Udang', selectedValue ?? ''); // Jenis udang
    await prefs.setString('Tambak', pilihanValue ?? ''); // Jenis tambak
  }
  Future<void> _saveToFirestore() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': widget.displayName,
      'email': widget.email,
      'photoUrl': widget.photoUrl,
    }, SetOptions(merge: true)); // merge agar tidak overwrite jika sudah ada data
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
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
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              child: Text(
                'Jenis Udang',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String?>(
                value: selectedValue,
                items: ["Udang Vaname", "Udang Galah", "Udang Windu"]
                    .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Pilih Jenis Udang"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 15, top: 15),
              child: Text(
                'Jenis Tambak',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String?>(
                value: pilihanValue,
                items: ["Tradisional", "Intensif", "Super Intensif"]
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    activeColor: Colors.blue[900],
                  ),
                  const Text(
                    "Pengaturan Sudah Sesuai",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedValue != null &&
                          pilihanValue != null &&
                          isChecked) {
                        await _savePreferences(); // Simpan data ke SharedPreferences
                         await _saveToFirestore(); // Simpan ke Firestore
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ControlPage(
                              Suhu: "", // Nilai Suhu kosong karena dihitung di ControlPage
                              pH: "", // Nilai pH kosong karena dihitung di ControlPage
                              DO: "", // Nilai DO kosong karena dihitung di ControlPage
                              TDS: "", // Nilai TDS kosong karena dihitung di ControlPage
                              Udang: selectedValue!,
                              Tambak: pilihanValue!,
                            ),
                          ),
                        );
                      } else {
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
                            backgroundColor: Colors.grey[350],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      "Selanjutnya",
                      style: TextStyle(fontSize: 17, letterSpacing: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
