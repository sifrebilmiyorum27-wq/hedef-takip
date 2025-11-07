import 'package:flutter/material.dart';
import '../data/tyt_turkce.dart';
import '../data/tyt_matematik.dart';
import '../data/tyt_fizik.dart';
import '../data/tyt_kimya.dart';
import '../data/tyt_geometri.dart';
import '../data/tyt_biyoloji.dart';
import '../data/ayt_matematik.dart';
import '../data/konular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ders seçme alanı için liste
  final Map<String, List<Map<String, dynamic>>> dersler = {
    "TYT Türkçe": tyt_turkce,
    "TYT Matematik": tyt_matematik,
    "TYT Geometri": tyt_geometri,
    "TYT Fizik": tyt_fizik,
    "TYT Kimya": tyt_kimya,
    "TYT Biyoloji": tyt_biyoloji,
    "AYT Matematik": ayt_matematik,
  };

  String secilenDers = "TYT Türkçe";

  @override
  void initState() {
    super.initState();
    yukleKonular().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> aktifListe = dersler[secilenDers]!;
    int tamamlananSayisi = aktifListe.where((k) => k["tamamlandi"] == true).length;
    double ilerleme = tamamlananSayisi / aktifListe.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hedef Takip"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // ⭐ Açılır Menü (Dropdown)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField(
              value: secilenDers,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: dersler.keys.map((ders) {
                return DropdownMenuItem(value: ders, child: Text(ders));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  secilenDers = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // İlerleme barı
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(value: ilerleme, minHeight: 8),
          ),
          Text("% ${(ilerleme * 100).toStringAsFixed(0)} tamamlandı",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),

          // Konu Listesi
          Expanded(
            child: ListView.builder(
              itemCount: aktifListe.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(aktifListe[index]["ad"]),
                  value: aktifListe[index]["tamamlandi"],
                  onChanged: (deger) {
                    setState(() {
                      aktifListe[index]["tamamlandi"] = deger;
                      kaydetKonular();
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
