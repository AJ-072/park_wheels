import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lot.dart';

class LotService {
  static const String parking_lots = 'parking_lots';

  static CollectionReference<Lot> _collections() =>
      FirebaseFirestore.instance.collection(parking_lots).withConverter<Lot>(
          fromFirestore: (snap, _) => Lot.fromMap(snap.data() ?? {}),
          toFirestore: (lot, _) => Lot.toMap(lot));

  static Query<Lot> get() => _collections();
}
