
class _User{
 late int ID;
late  String name;
 late String  email;
 late String  num;
late  String  pass;
 late String  pic;
 late String  lo;
 late String  lat;
 late String  ad;
late  String  city;
 late String  country;
 late String  status;
late  String  type;
 late String  log;
 late String  create;

  _User({required this.ID,required this.name,required this.email,required this.num,required this.pass,required this.pic,required this.lo,required this.lat,required this.ad,required this.city,required this.country,required this.status,required this.type,required this.log,required this.create});




 factory _User.fromJson(Map<String, dynamic> json) {

   return _User(
     ID:json['id'],
     name:json['name'],
     email:json['email'],
     num:json['number'],
     pass:json['password'],
    pic :json['pic'],
     lo:json['lon'],
     lat:json['lat'],
     ad:json['address'],
     city:json['city'],
     country:json['country'],
     status:json['status'],
     type:json['type'],
     create:json['create'],
     log:json['last_log'],


   );
 }


 Map<String, dynamic> toJson() => {
   'id': ID,
   'name': name,
   'email': email,
   'number': num,
   'password':pass,
   'pic': pic,
   'lon': lo,
   'lat': lat,
   'address': ad,
   'city':city,
   'country':country,
   'status':status,
   'type': type,
   'create':create,
   'last_log': log
 };

}