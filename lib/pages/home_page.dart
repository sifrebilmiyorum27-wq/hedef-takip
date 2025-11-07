import 'package:flutter/material.dart';
import '../data/konular.dart';
import '../data/ayt_matematik.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String seciliSeviye = "TYT"; // Seçili seviye (TYT - AYT)

  @override
  void initState() {
    super.initState();
    yukleKonular().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aktif konu listesini seçiyoruz
    final aktifListe = seciliSeviye == "TYT" ? konular : aytMatematik;

    int tamamlananSayisi =
        aktifListe.where((k) => k["tamamlandi"] == true).length;
    double ilerleme =
        aktifListe.isEmpty ? 0 : tamamlananSayisi / aktifListe.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konu Takip"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // ✅ TYT / AYT seçim kutusu
          DropdownButton<String>(
            value: seciliSeviye,
            items: const [
              DropdownMenuItem(value: "TYT", child: Text("TYT Konuları")),
              DropdownMenuItem(value: "AYT", child: Text("AYT Konuları")),
            ],
            onChanged: (value) {
              setState(() {
                seciliSeviye = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          // ✅ İlerleme çubuğu
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

          // ✅ Konu listesi
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
                      kaydetKonular(); // ✅ Kaydediyoruz
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
