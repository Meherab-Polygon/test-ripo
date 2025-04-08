enum TradeStatus { active, completed }
enum TradeResult { yes, no, pending }

class Trade {
  final String id;
  final String question;
  final String description;
  final DateTime createdAt;
  final DateTime expiresAt;
  final TradeStatus status;
  final TradeResult result;
  final int yesCount;
  final int noCount;
  final String category;
  final String matchId;

  Trade({
    required this.id,
    required this.question,
    required this.description,
    required this.createdAt,
    required this.expiresAt,
    this.status = TradeStatus.active,
    this.result = TradeResult.pending,
    this.yesCount = 0,
    this.noCount = 0,
    required this.category,
    required this.matchId,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'],
      question: json['question'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      status: TradeStatus.values.byName(json['status']),
      result: TradeResult.values.byName(json['result']),
      yesCount: json['yesCount'] ?? 0,
      noCount: json['noCount'] ?? 0,
      category: json['category'],
      matchId: json['matchId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'status': status.name,
      'result': result.name,
      'yesCount': yesCount,
      'noCount': noCount,
      'category': category,
      'matchId': matchId,
    };
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  
  double get yesPercentage => 
      (yesCount + noCount) > 0 ? (yesCount / (yesCount + noCount) * 100) : 50;
  
  double get noPercentage => 
      (yesCount + noCount) > 0 ? (noCount / (yesCount + noCount) * 100) : 50;
}

