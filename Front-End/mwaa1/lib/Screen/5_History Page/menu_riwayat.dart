import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/3_Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/5_History%20Page/grafik_page.dart';
import 'package:mwaa1/Screen/5_History%20Page/history_page.dart';
import 'package:mwaa1/Screen/5_History%20Page/tab_item.dart';
import 'package:mwaa1/Screen/6_Profile%20Page/profile_page.dart';
import 'package:mwaa1/Screen/control_page.dart';

class MenuRiwayat extends StatefulWidget {
  const MenuRiwayat({super.key});

  @override
  State<MenuRiwayat> createState() => _MenuRiwayatState();
}

class _MenuRiwayatState extends State<MenuRiwayat> {
  bool _isAuthorized = false; // Status validasi kode unik
  final TextEditingController _kodeUnikController = TextEditingController();
  String? selectedValue; // Jenis Udang
  String? pilihanValue; // Jenis Tambak

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
                      content: const Text("Kembali ke Halaman Utama"),
                      actions: [
                        TextButton(
                          onPressed: () {
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
              "Kode unik yang anda masukan valid, anda dapat melihat riwayat dan grafik dari pemantauan tambak mu!"),
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

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orange,
            title: Image.asset(
              "assets/LOGOaja.png",
              color: Colors.white,
              height: 100,
              width: 100,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          TabItem(title: 'History'),
                          TabItem(title: 'Grafik'),
                        ]),
                  ),
                )),
          ),
          body: const TabBarView(children: [HistoryPage(), GrafikPage()]),
        ));
  }
}
