import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> konular = [
  {"ad": "Temel Kavramlar", "tamamlandi": false},
  {"ad": "Rasyonel Sayılar", "tamamlandi": false},
  {"ad": "Problemler", "tamamlandi": false},
  {"ad": "Fonksiyonlar", "tamamlandi": false},
];

Future<void> kaydetKonular() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> durumlar = konular.map((k) => k["tamamlandi"].toString()).toList();
  prefs.setStringList("konuDurumlari", durumlar);
}

Future<void> yukleKonular() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? durumlar = prefs.getStringList("konuDurumlari");

  if (durumlar != null) {
    for (int i = 0; i < konular.length; i++) {
      konular[i]["tamamlandi"] = (durumlar[i] == "true");
    }
  }
}
