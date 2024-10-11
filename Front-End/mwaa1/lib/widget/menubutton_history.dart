import 'package:flutter/material.dart';
import 'package:mwaa1/widget/menu_item.dart';
import 'package:mwaa1/widget/theme.dart';

class MenubuttonHistory extends StatefulWidget {
  const MenubuttonHistory({super.key});

  @override
  State<MenubuttonHistory> createState() => _MenubuttonHistoryState();
}

class _MenubuttonHistoryState extends State<MenubuttonHistory> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              "Riwayat",
              style: opensans17normal.copyWith(
                  color: blueriwayat,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.0),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("Periode Riwayat",
              style: poppin15normal.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0)),
          SizedBox(
            height: 16,
          ),
          Text("Dari Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("Sampai Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("Kata Sandi",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: _isObscure,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }, 
                  icon: Icon(_isObscure? Icons.visibility : Icons.visibility_off)),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 30),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: bluelogin),
                    child: Text(
                      "Batal",
                      style: outfit15normal.copyWith(color: Colors.white, letterSpacing: 1.0),
                    )
                ),
                SizedBox(width: 60,),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 30),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: bluelogin),
                    child: Text(
                      "Selesai",
                      style: outfit15normal.copyWith(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
