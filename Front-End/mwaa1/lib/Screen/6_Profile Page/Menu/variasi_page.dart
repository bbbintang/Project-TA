import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/3_Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/2_Registrasi%20Page/regis_screen.dart';
import 'package:mwaa1/Screen/control_page.dart';
import 'package:mwaa1/Screen/6_Profile%20Page/profile_page.dart';
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
  bool _isAuthorized = false; // Status validasi kode unik
  final TextEditingController _kodeUnikController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showKodeUnikDialog(); // Tampilkan dialog validasi saat halaman dimulai
    });
  }

  Future<void> _showKodeUnikDialog() async {
    const String validKodeUnik = "12345"; // Kode unik yang valid

    await showDialog(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Masukkan Kode Unik"),
          content: TextField(
            controller: _kodeUnikController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Kode Unik"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                if (selectedValue != null && pilihanValue != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ControlPage(
                        Suhu: '',
                        pH: '',
                        DO: '',
                        TDS: '',
                        Udang: '',
                        Tambak: '',
                      ), // Ganti dengan halaman utama Anda
                    ),
                    (Route<dynamic> route) =>
                        false, // Hapus semua rute sebelumnya
                  );
                } else {
                  // Tampilkan pesan error atau lakukan penanganan lain jika nilai null
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Peringatan"),
                      content: const Text(
                          "Kembali ke Halaman Utama"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                      backgroundColor: Colors.grey[350],
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 146, 255),
              ),
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                if (_kodeUnikController.text == validKodeUnik) {
                  setState(() {
                    _isAuthorized = true; // Jika kode valid, izinkan akses
                  });
                  Navigator.of(context).pop(); // Tutup dialog
                  _showSuccessDialog(); // Tampilkan dialog sukses
                } else {
                  _showErrorDialog(); // Tampilkan dialog error
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 146, 255),
              ),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kode Unik Valid"),
          content: Text(
              "Kode unik yang anda masukan valid, silahkan ubah variasi budidaya mu!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog sukses
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 146, 255),
              ),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog() async {
    await showDialog(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kode Unik Salah"),
          content: Text(
              "Kode unik yang anda masukkan salah. Silahkan hubungi pengembang aplikasi untuk mendapatkan kode unik."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog error
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 146, 255),
              ),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthorized) {
      // Tampilkan indikator loading sementara validasi belum selesai
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                  items: ["Udang Vaname", "Udang Galah", "Udang Windu"]
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
