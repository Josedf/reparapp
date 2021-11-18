import '../common/Status.dart';

class Request {
  final String address;
  final String category;
  final String city;
  final String description;

  final List<String> image64List; //Image in base64;
  final String clientName;
  final String phone;
  final String title;
  final String time;
  final String price;
  final String clientAgree;
  final String fixerAgree;
  final String requestId;
  final String status;
  String fixerName;
  String fixerEmail;
  String latitude;
  String longitude;

  //final String id;

  Request(
      {required this.address,
      required this.category,
      required this.city,
      required this.description,
      required this.image64List,
      required this.clientName,
      required this.phone,
      required this.title,
      required this.time,
      required this.price,
      required this.clientAgree,
      required this.fixerAgree,
      required this.requestId,
      required this.status,
      this.fixerName = "",
      this.fixerEmail = "",
      this.latitude = "",
      this.longitude = ""});

  bool clientAgrees() {
    return clientAgree == "True";
  }

  bool fixerAgrees() {
    return fixerAgree == "True";
  }

  void setFixerName(String name) {
    fixerName = name;
  }

  void setFixerEmail(String email) {
    fixerEmail = email;
  }

  Status getStatus() {
    return Status.values.firstWhere((element) => element.toString() == status);
  }
}
