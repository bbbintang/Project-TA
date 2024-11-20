import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/grafik_page.dart';
import 'package:mwaa1/Screen/History%20Page/history_page.dart';
import 'package:mwaa1/Screen/Location%20Page/tab_item.dart';

class MenuRiwayat extends StatelessWidget {
  const MenuRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Image.asset(
              "LOGOaja.png",
              color: Colors.orange,
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
          body: const TabBarView(children: [
            HistoryPage(),
            GrafikPage()
          ]),
        ));
  }
}
