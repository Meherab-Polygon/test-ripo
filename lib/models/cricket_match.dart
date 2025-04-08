class CricketMatch {
  final String id;
  final String team1;
  final String team2;
  final String team1Flag;
  final String team2Flag;
  final String venue;
  final DateTime startTime;
  final String status;
  final String score1;
  final String score2;
  final String overs1;
  final String overs2;
  final String result;

  CricketMatch({
    required this.id,
    required this.team1,
    required this.team2,
    required this.team1Flag,
    required this.team2Flag,
    required this.venue,
    required this.startTime,
    required this.status,
    this.score1 = '',
    this.score2 = '',
    this.overs1 = '',
    this.overs2 = '',
    this.result = '',
  });

  factory CricketMatch.fromJson(Map<String, dynamic> json) {
    return CricketMatch(
      id: json['id'],
      team1: json['team1'],
      team2: json['team2'],
      team1Flag: json['team1Flag'],
      team2Flag: json['team2Flag'],
      venue: json['venue'],
      startTime: DateTime.parse(json['startTime']),
      status: json['status'],
      score1: json['score1'] ?? '',
      score2: json['score2'] ?? '',
      overs1: json['overs1'] ?? '',
      overs2: json['overs2'] ?? '',
      result: json['result'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team1': team1,
      'team2': team2,
      'team1Flag': team1Flag,
      'team2Flag': team2Flag,
      'venue': venue,
      'startTime': startTime.toIso8601String(),
      'status': status,
      'score1': score1,
      'score2': score2,
      'overs1': overs1,
      'overs2': overs2,
      'result': result,
    };
  }

  bool get isLive => status == 'live';
  bool get isUpcoming => status == 'upcoming';
  bool get isCompleted => status == 'completed';
}

