enum AccountProvider {
  facebook(name: "Facebook"),
  github(name: "GitHub"),
  google(name: "Google");

  const AccountProvider({required this.name});

  final String name;
}
