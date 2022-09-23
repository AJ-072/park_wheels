enum ItemType {
  slot,
  gate,
}

class ItemData {
  String? id;
  double dx, dy;
  int dr;
  ItemType type;

  ItemData(
      {this.id,
      required this.dx,
      required this.dy,
      this.dr = 0,
      required this.type});

  ItemData.fromMap(Map map)
      : this(
            id: map['id'],
            dx: map['dx'] as double,
            dy: map['dy'] as double,
            dr: map['dr'] as int,
            type: ItemType.values[0]);

  Map toMap() => {'id': id, 'dx': dx, 'dy': dy, 'dr': dr, 'type': type.index};
}
