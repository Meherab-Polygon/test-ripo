class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String profileImage;
  int balance;
  final List<String> activeTrades;
  final List<String> completedTrades;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    this.balance = 10000, // Default starting balance
    this.activeTrades = const [],
    this.completedTrades = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profileImage'],
      balance: json['balance'] ?? 10000,
      activeTrades: List<String>.from(json['activeTrades'] ?? []),
      completedTrades: List<String>.from(json['completedTrades'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'balance': balance,
      'activeTrades': activeTrades,
      'completedTrades': completedTrades,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? profileImage,
    int? balance,
    List<String>? activeTrades,
    List<String>? completedTrades,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      balance: balance ?? this.balance,
      activeTrades: activeTrades ?? this.activeTrades,
      completedTrades: completedTrades ?? this.completedTrades,
    );
  }
  
  void updateBalance(int amount) {
    balance += amount;
  }
}

