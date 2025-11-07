import 'package:flutter/material.dart';
import '../data/konular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    yukleKonular().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int tamamlananSayisi = konular.where((k) => k["tamamlandi"] == true).length;
    double ilerleme = tamamlananSayisi / konular.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konu Takip"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // İlerleme gösterge barı
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              value: ilerleme,
              minHeight: 10,
            ),
          ),
          Text(
            "% ${(ilerleme * 100).toStringAsFixed(0)} tamamlandı",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Konu Listesi
          Expanded(
            child: ListView.builder(
              itemCount: konular.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(konular[index]["ad"]),
                  value: konular[index]["tamamlandi"],
                  onChanged: (deger) {
                    setState(() {
                      konular[index]["tamamlandi"] = deger;
                      kaydetKonular(); // ✅ KAYDEDİYORUZ
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
