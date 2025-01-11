import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class Autofeeder extends StatefulWidget {
  const Autofeeder({super.key});

  @override
  State<Autofeeder> createState() => _AutofeederState();
}

class _AutofeederState extends State<Autofeeder> {
  var isChecked = false;
  String? selectedValue;
  String? pilihanValue;
  bool _isObscure = true;
  bool statusSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Autorator\n',
                      style: poppin20bold.copyWith(
                        color: Colors.black87,
                        letterSpacing: 1.3,
                        fontSize: 25,
                      )),
                  TextSpan(
                      text: 'Automatic Aerator \n\n\n',
                      style: poppin15normal.copyWith(color: Colors.black54)),
                  TextSpan(
                      text:
                          'Silahkan memilih rentang waktu untuk \n mengaktifkan Autofeeder',
                      style: poppin15normal.copyWith(color: Colors.black54)),
                ]),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Text(
                    "Otomatisasi",
                    style: poppin15normal.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 160,
                  ),
                  Switch(
                    value: statusSwitch,
                    onChanged: (value) {
                      setState(() {
                        statusSwitch =
                            !statusSwitch; //menandakan keadaan berubah
                      });
                      print(statusSwitch);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Row(
                children: [
                  Text(
                    "Durasi",
                    style: poppin15normal.copyWith(
                        color: Colors.black, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 60,
                    width: 70,
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: DropdownButton<String?>(
                      value: selectedValue,
                      items: ["1", "2", "3", "4", "5"]
                          .map<DropdownMenuItem<String?>>(
                              (e) => DropdownMenuItem(
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
                      hint: Icon(Icons.timer_sharp),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jam",
                    style: poppin15normal.copyWith(
                        color: Colors.black, letterSpacing: 1.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
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
                    style: poppin15normal.copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 16, right: 16, bottom: 16),
              child: Text(
                'Kata Sandi',
                style:
                    poppin15normal.copyWith(color: Colors.black, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(_isObscure
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                children: [
                  SizedBox(
                    width: 230,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(80, 30),
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
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
      ),
    );
  }
}
