class UserProfil {
  final String name, firstName, city, email;

  UserProfil({
    this.name,
    this.firstName,
    this.city,
    this.email,
  });

  fromJson(json) {
    return UserProfil(
        name: json['name'],
        firstName: json['firstName'],
        city: json['city'],
        email: json['email']);
  }
}

class ItemArguments {
  final String text;

  ItemArguments({this.text});
}
