import '../models/cricket_match.dart';
import '../models/trade.dart';
import '../models/user.dart';

class DummyData {
  // Dummy Users
  static List<User> getDummyUsers() {
    return [
      User(
        id: '1',
        name: 'Virat Kohli',
        username: 'virat18',
        email: 'virat@example.com',
        profileImage: 'https://i.ibb.co/P6zcgCB/virat-kohli.jpg',
        balance: 25000,
        activeTrades: ['1', '3'],
        completedTrades: ['2', '4'],
      ),
      User(
        id: '2',
        name: 'Rohit Sharma',
        username: 'hitman45',
        email: 'rohit@example.com',
        profileImage: 'https://i.ibb.co/FmNxhHr/rohit-sharma.jpg',
        balance: 18000,
        activeTrades: ['1', '5'],
        completedTrades: ['2'],
      ),
      User(
        id: '3',
        name: 'MS Dhoni',
        username: 'msd7',
        email: 'dhoni@example.com',
        profileImage: 'https://i.ibb.co/Tkc0qJK/ms-dhoni.jpg',
        balance: 30000,
        activeTrades: ['3'],
        completedTrades: ['4', '5'],
      ),
      User(
        id: '4',
        name: 'Jasprit Bumrah',
        username: 'boom93',
        email: 'bumrah@example.com',
        profileImage: 'https://i.ibb.co/zNtxXhB/bumrah.jpg',
        balance: 15000,
        activeTrades: ['5'],
        completedTrades: ['1', '2'],
      ),
    ];
  }

  // Dummy Trades (unchanged)
  static List<Trade> getDummyTrades() {
    return [
      Trade(
        id: '1',
        question: 'Will India win the toss?',
        description:
            'Predict if India will win the toss in the upcoming match against Australia.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        expiresAt: DateTime.now().add(const Duration(hours: 3)),
        status: TradeStatus.active,
        result: TradeResult.pending,
        yesCount: 120,
        noCount: 80,
        category: 'Cricket',
        matchId: '1',
      ),
      Trade(
        id: '2',
        question: 'Will Virat Kohli score a century?',
        description:
            'Predict if Virat Kohli will score a century in the match against Australia.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        expiresAt: DateTime.now().add(const Duration(hours: 5)),
        status: TradeStatus.active,
        result: TradeResult.pending,
        yesCount: 150,
        noCount: 50,
        category: 'Cricket',
        matchId: '1',
      ),
      Trade(
        id: '3',
        question: 'Will there be a super over?',
        description:
            'Predict if the match between India and Australia will go to a super over.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        status: TradeStatus.active,
        result: TradeResult.pending,
        yesCount: 30,
        noCount: 170,
        category: 'Cricket',
        matchId: '1',
      ),
      Trade(
        id: '4',
        question: 'Will Rohit Sharma be the top scorer?',
        description:
            'Predict if Rohit Sharma will be the top scorer for India in the match.',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 10)),
        status: TradeStatus.completed,
        result: TradeResult.yes,
        yesCount: 200,
        noCount: 100,
        category: 'Cricket',
        matchId: '2',
      ),
      Trade(
        id: '5',
        question: 'Will India win by more than 50 runs?',
        description:
            'Predict if India will win the match by more than 50 runs.',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 15)),
        status: TradeStatus.completed,
        result: TradeResult.no,
        yesCount: 80,
        noCount: 220,
        category: 'Cricket',
        matchId: '2',
      ),
    ];
  }

  // Dummy Cricket Matches with Real Flag URLs
  static List<CricketMatch> getDummyCricketMatches() {
    return [
      CricketMatch(
        id: '1',
        team1: 'India',
        team2: 'Australia',
        team1Flag: 'https://flagcdn.com/w80/in.png',
        team2Flag: 'https://flagcdn.com/w80/au.png',
        venue: 'Melbourne Cricket Ground',
        startTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'live',
        score1: '187/4',
        score2: '',
        overs1: '32.4',
        overs2: '',
      ),
      CricketMatch(
        id: '2',
        team1: 'England',
        team2: 'South Africa',
        team1Flag: 'https://flagcdn.com/w80/gb.png',
        team2Flag: 'https://flagcdn.com/w80/za.png',
        venue: 'Lords Cricket Ground',
        startTime: DateTime.now().subtract(const Duration(hours: 1)),
        status: 'live',
        score1: '120/3',
        score2: '',
        overs1: '15.2',
        overs2: '',
      ),
      CricketMatch(
        id: '3',
        team1: 'New Zealand',
        team2: 'Pakistan',
        team1Flag: 'https://flagcdn.com/w80/nz.png',
        team2Flag: 'https://flagcdn.com/w80/pk.png',
        venue: 'Eden Park',
        startTime: DateTime.now().add(const Duration(hours: 5)),
        status: 'upcoming',
      ),
      CricketMatch(
        id: '4',
        team1: 'Sri Lanka',
        team2: 'Bangladesh',
        team1Flag: 'https://flagcdn.com/w80/lk.png',
        team2Flag: 'https://flagcdn.com/w80/bd.png',
        venue: 'R. Premadasa Stadium',
        startTime: DateTime.now().add(const Duration(hours: 8)),
        status: 'upcoming',
      ),
      CricketMatch(
        id: '5',
        team1: 'West Indies',
        team2: 'Afghanistan',
        team1Flag: 'https://flagcdn.com/w80/jm.png',
        team2Flag: 'https://flagcdn.com/w80/af.png',
        venue: 'Kensington Oval',
        startTime: DateTime.now().add(const Duration(days: 1)),
        status: 'upcoming',
      ),
      CricketMatch(
        id: '6',
        team1: 'India',
        team2: 'Pakistan',
        team1Flag: 'https://flagcdn.com/w80/in.png',
        team2Flag: 'https://flagcdn.com/w80/pk.png',
        venue: 'Dubai International Stadium',
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        status: 'completed',
        score1: '287/6',
        score2: '253/10',
        overs1: '50.0',
        overs2: '48.3',
        result: 'India won by 34 runs',
      ),
    ];
  }
}
