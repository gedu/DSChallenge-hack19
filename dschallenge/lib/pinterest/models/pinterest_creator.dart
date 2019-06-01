class PinterestCreator {
  final String firstName;
  final String lastName;
  final String id;

  PinterestCreator({this.id, this.firstName, this.lastName});

  PinterestCreator.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json["first_name"],
        lastName = json["last_name"];
}
