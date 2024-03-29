class Offer {
  final String address;
  final String category;
  final String city;
  final String description;

  final List<String> image64List; //Image in base64;
  final String name;
  final String phone;
  final String title;
  final String time;
  final String price;
  //final String id;

  Offer({
    required this.address,
    required this.category,
    required this.city,
    required this.description,
    required this.image64List,
    required this.name,
    required this.phone,
    required this.title,
    required this.time,
    required this.price,
    //required this.id,
  });
}