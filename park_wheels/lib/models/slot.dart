enum SlotType{
  slot,
  gate,
}

class SlotData{
  String? id;
  double dx,dy,dr;
  SlotType type;
  SlotData({this.id,required this.dx, required this.dy,this.dr=0,required this.type});

}