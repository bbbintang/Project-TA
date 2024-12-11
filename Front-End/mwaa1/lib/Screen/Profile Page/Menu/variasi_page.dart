import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/Registrasi%20Page/regis_screen.dart';
import 'package:mwaa1/Screen/control_page.dart';
import 'package:mwaa1/widget/theme.dart';

class VariasiPage extends StatefulWidget {
  const VariasiPage({super.key});

  @override
  State<VariasiPage> createState() => _VariasiPageState();
}

class _VariasiPageState extends State<VariasiPage> {
  String? selectedValue;
  String? pilihanValue;
  var isChecked = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            "assets/LOGOaja.png",
            color: Colors.orange,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Variasi",
                  style: poppin20bold.copyWith(
                      color: Colors.black87, letterSpacing: 1.0, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 16, right: 16, bottom: 10),
                child: Text(
                  "Jenis Udang",
                  style: poppin15normal.copyWith(
                      color: Colors.black, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
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
                padding: const EdgeInsets.only(
                    top: 30, left: 16, right: 16, bottom: 16),
                child: Text(
                  'Jenis Tambak',
                  style: poppin15normal.copyWith(
                      color: Colors.black, fontSize: 17),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
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
                      activeColor: Colors.blue[900],
                    ),
                    Text(
                      "Pengaturan Sudah Sesuai",
                      style: poppin15normal.copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (selectedValue == null && pilihanValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Pastikan semua pilihan telah diisi dan ceklis pengaturan sesuai"),
                              ),
                            );
                          } else if (selectedValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pilih Jenis Udang mu!"),
                              ),
                            );
                          } else if (pilihanValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pilih Jenis Tambak mu!"),
                              ),
                            );
                          } else if (!isChecked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Harap Centang pengaturan sudah sesuai"),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ControlPage(
                                  Udang: selectedValue!,
                                  Tambak: pilihanValue!,
                                  Suhu: '',
                                  DO: '',
                                  pH: '',
                                  TDS: '',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(330, 40),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: bluelogin),
                        child: Text(
                          "Selesai",
                          style: outfit15normal.copyWith(color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
