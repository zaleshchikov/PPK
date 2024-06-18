
import 'dart:typed_data';

class ProfileModel{
  int id;
  String name;
  Uint8List photo;
  bool hasCatcoinVlad;
  bool hasCatcoinSasha;
  bool hasCatcoinLera;
  bool hasCatcoinKsusha;
  bool hasCatcoinKolya;

  ProfileModel(
      {required this.id,
        required this.name,
        required this.photo,
        required this.hasCatcoinVlad,
        required this.hasCatcoinSasha,
        required this.hasCatcoinLera,
        required this.hasCatcoinKsusha,
        required this.hasCatcoinKolya});
}