import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: "Apa itu MWA System ?",
      answer:
          "MWA System merupakan sebuah produk yang dirancang untuk membantu memantau dan mengontrol kualitas air dengan menggunakan Internet of Things yang dapat diakses oleh petambak melalui aplikasi seluler. Penggunakan Internet of Things sebagai penghubung bertujuan untuk memantau kualitas air pada tambak dan mengelola hasil pengukurannya. Selain itu, Internet of Things berperan untuk otomatisasi aerator guna mengontrol kurangnya kadar oksigen dalam air. MWA System merupakan penunjang kelulusan mahasiswa dengan Misi untuk membantu petambak dalam memantau kualitas air pada tambak agar dapat mengurangi terjadinya kegagalan panen yang mengakibatkan kerugian pada petambak.",
    ),
    FAQItem(
      question: "Data apa yang dikumpulkan ?",
      answer:
          "Kami mengumpulkan data terkait kualitas air seperti suhu air, asam dan basa air, kemudian kekeruhan serta oksigen terlarut dalam kandungan air tersebut melalui alat dan sensor yang telah disiapkan. data yang telah dikumpulkan akan masuk ke firebase yang kemudian diolah dan ditampilkan pada aplikasi ini",
    ),
    FAQItem(
      question: "Siapa Pengembangnya ?",
      answer: "MWA System ini dirancang dan dikembangkan oleh mahasiswa/i Telkom University \n\n 1. Azkiya Nafis Ikrimah [1101213062]\n 2. Fauzan Prayoga [1101213012]\n 3. Narita Balqis [1101213262]\n 4. Zahra Bintang [1101213304]",
    ),
  ];

  FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return FAQItemWidget(faqItem: faqItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem faqItem;

  const FAQItemWidget({super.key, required this.faqItem});

  @override
  State<FAQItemWidget> createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shadowColor: Colors.orange[100],
      color: const Color(0xFFFFFCF2),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpand,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.faqItem.question,
                      style: poppin15normal.copyWith(color: Colors.black, fontWeight: FontWeight.w600)
                    ),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                    child: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.faqItem.answer,
                style: poppin15normal.copyWith(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}