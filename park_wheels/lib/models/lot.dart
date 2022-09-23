import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Lot {
  String _id = Random().nextDouble().toString();
  String? _name;
  String? _address;
  int? _slots;
  double? _slotPrice;
  String? _owner;
  GeoPoint? _location;

  String get id => _id;

  String get name => _name ?? '';

  String get address => _address ?? '';

  String get owner => _owner ?? '';

  int get slots => _slots ?? 0;

  double get slotPrice => _slotPrice ?? 0;

  GeoPoint get location => _location ?? const GeoPoint(0, 0);

  set name(String name) => _name = name;

  set address(String address) => _address = address;

  set slots(int slot) => _slots = slot;

  set slotPrice(double slotPrice) => _slotPrice = slotPrice;

  set location(GeoPoint location) => _location = location;

  Lot(
    this._owner, {
    String? address,
    int slots = 0,
    String? name,
    GeoPoint? location,
  }) {
    _name = name;
    _address = address;
    _slots = slots;
    _location = location;
    _owner = owner;
  }

  Lot.fromMap(Map<String, dynamic> map) {
    _id = map['id'] ?? "";
    _name = map['name'] ?? "";
    _address = map['address'] ?? "";
    _slots = (map['slots'] as int?) ?? 0;
    _slotPrice = (map['slotPrice'] as double?) ?? 0;
    _location = (map['location'] as GeoPoint?) ?? GeoPoint(0, 0);
    _owner = map['owner'] ?? "";
  }

  static toMap(Lot lot) {
    return {
      'id': lot.id,
      'name': lot.name,
      'address': lot.address,
      'slots': lot.slots,
      'slotPrice': lot.slotPrice,
      'location': lot.location,
      'owner': lot.owner,
    };
  }
}
