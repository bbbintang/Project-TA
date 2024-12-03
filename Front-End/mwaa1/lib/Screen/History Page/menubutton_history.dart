import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mwaa1/widget/theme.dart';

class MenubuttonHistory extends StatefulWidget {
  const MenubuttonHistory({super.key});

  @override
  State<MenubuttonHistory> createState() => _MenubuttonHistoryState();
}

class _MenubuttonHistoryState extends State<MenubuttonHistory> {
  bool _isObscure = true;
  TextEditingController dateControllerAwal = TextEditingController();
  TextEditingController dateControllerAkhir = TextEditingController();
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
              "Periode Riwayat",
              style: opensans17normal.copyWith(
                color: blueriwayat,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Dari Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
            child: TextField(
              readOnly: true,
              controller: dateControllerAwal,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Date',
                  suffixIcon: Icon(Icons.calendar_month_rounded)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyy-MM-dd').format(pickedDate);
                  dateControllerAwal.text = formattedDate;
                }
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("Sampai Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
            child: TextField(
              readOnly: true,
              controller: dateControllerAkhir,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Date',
                  suffixIcon: Icon(Icons.calendar_month_rounded)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyy-MM-dd').format(pickedDate);
                  dateControllerAkhir.text = formattedDate;
                }
              },
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
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off)),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 30),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    backgroundColor: bluelogin),
                child: Text(
                  "Selesai",
                  style: outfit15normal.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
