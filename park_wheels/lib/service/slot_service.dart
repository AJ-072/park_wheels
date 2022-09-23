import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/slot.dart';

class SlotService {
  static CollectionReference<ItemData> _collection(String id) =>
      FirebaseFirestore.instance
          .collection('parking_lots')
          .doc(id)
          .collection('slots')
          .withConverter(
              fromFirestore: (snapshot, _) =>
                  ItemData.fromMap(snapshot.data() ?? {}),
              toFirestore: (data, _) => data.toMap() as Map<String, dynamic>);

  // static Query getByOwner(String id) => _collection(id).where("owner",isEqualTo: FirebaseAuth.instance.currentUser?.uid??"");

  static Query<ItemData> get(String lot) => _collection(lot);

  static set(ItemData data, String lot) =>
      _collection(lot).doc(data.id).set(data);
}
