import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/random.dart';

enum Status { cancelled, paid, parked, expired, completed }

class Booking {
  String? id;
  String? _clientID;
  String? _clientName;
  String? _clientEmail;
  String? _lotID;
  String? _lotName;
  String? _lotAddress;
  double? _cost;
  String? _slot;
  DateTime? _createdAt;
  DateTime? _bookedTime;
  Status? _status;

  set clientID(String clientID) => _clientID = clientID;

  set clientName(String clientName) => _clientName = clientName;

  set clientEmail(String clientEmail) => _clientEmail = clientEmail;

  set lotID(String lotID) => _lotID = lotID;

  set lotAddress(String value) => _lotAddress = value;

  set lotName(String value) => _lotName = value;

  set cost(double value) => _cost = value;

  set slot(String value) => _slot = value;

  set createdAt(DateTime value) => _createdAt = value;

  set bookedTime(DateTime value) => _bookedTime = value;

  set status(Status value) => _status = value;

  String get clientID => _clientID ?? "";

  String get clientName => _clientName ?? "";

  String get clientEmail => _clientEmail ?? "";

  String get lotID => _lotID ?? "";

  String get lotName => _lotName ?? "";

  String get lotAddress => _lotAddress ?? "";

  double get cost => _cost ?? 0;

  String get slot => _slot ?? "";

  DateTime get createdAt => _createdAt ?? DateTime.now();

  DateTime get bookedTime => _bookedTime ?? DateTime.now();

  Status get status => _status ?? Status.cancelled;

  Booking(
      {this.id,
      String? clientID,
      String? clientName,
      String? clientEmail,
      String? lotID,
      String? lotName,
      String? lotAddress,
      double? cost,
      String? slot,
      DateTime? createdAt,
      DateTime? bookedTime,
      Status? status}) {
    id = id ?? getRandomString(10);
    _clientID = clientID;
    _clientName = clientName;
    _clientEmail = clientEmail;
    _lotID = lotID;
    _lotAddress = lotAddress;
    _lotName = lotName;
    _slot = slot;
    _cost = cost;
    _createdAt = createdAt;
    _bookedTime = bookedTime;
    _status = status;
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    print(map['created_by']);
    return Booking(
        id: map['id'] as String,
        clientID: map['clientID'] as String,
        clientEmail: map['clientEmail'] as String,
        clientName: map['clientName'] as String,
        lotID: map['lotID'] as String,
        lotAddress: map['lotAddress'] as String,
        lotName: map['lotName'] as String,
        slot: map['slot'],
        cost: map['cost'] as double,
        createdAt: (map['created_At']! as Timestamp).toDate(),
        bookedTime: (map['booked_time']! as Timestamp).toDate(),
        status: Status.values[map['status'] as int]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientID': _clientID,
      'clientEmail': _clientEmail,
      'clientName': _clientName,
      'lotID': _lotID,
      'lotName': _lotName,
      'lotAddress': _lotAddress,
      'slot': _slot,
      'cost': _cost,
      'created_At': _createdAt,
      'booked_time': _bookedTime,
      'status': status.index
    };
  }
}
