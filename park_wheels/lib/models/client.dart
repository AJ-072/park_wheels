enum Status{
  cancelled,
  paid,
  parked,
  expired,
  completed
}

class Client {
  String id;
  String name;
  Duration duration;
  double cost;
  String slot;
  DateTime createdAt;
  DateTime bookedTime;
  Status status;
  Client({required this.id,required this.name,required this.slot,required this.cost,required this.duration,required this.createdAt,required this.bookedTime,required this.status});

  factory Client.fromMap(Map<String,dynamic> map){
    return Client(
        id: map['id'] as String,
        name : map['name'] as String,
        slot : map['slot'],
        cost : map['cost'] as double,
        duration : map['duration'] as Duration,
        createdAt : map['created_at'],
        bookedTime : map['booked_time'],
        status: map['status']
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'id'      : id,
      'name'    : name,
      'slot'    : slot,
      'duration': duration,
      'cost'    : cost,
      'created_At': createdAt,
      'booked_time': bookedTime
    };
  }
}