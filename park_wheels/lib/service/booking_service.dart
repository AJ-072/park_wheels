import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:park_wheels/models/booking.dart';

import '../main.dart';
import 'auth.dart';

class BookingService {
  static CollectionReference<Booking> _collection() =>
      FirebaseFirestore.instance.collection('booking').withConverter(
          fromFirestore: (snapshot, _) =>
              Booking.fromMap(snapshot.data() ?? {}),
          toFirestore: (data, _) => data.toMap());

  // static Query getByOwner(String id) => _collection(id).where("owner",isEqualTo: FirebaseAuth.instance.currentUser?.uid??"");

  static Query<Booking> get() => _collection()
      .where("clientID", isEqualTo: getIt<Auth>().client?.id ?? "");

  static Future set(Booking data) => _collection().doc(data.id).set(data);
}
