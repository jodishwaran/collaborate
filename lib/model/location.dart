class Location {
  String locationId;
  String locationName;
  String locationdesc;

  Location.fromJson(Map<String, dynamic> json)
      : locationId = json["locationId"],
        locationName = json["locationName"],
        locationdesc = json["locationdesc"];
}
//"locationId": "1",
//"locationName": "Bangalore",
//"locationdesc": "Bellandur Area"
