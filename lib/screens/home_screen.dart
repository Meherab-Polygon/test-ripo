import 'package:flutter/material.dart';

import '../models/cricket_match.dart';
import '../models/trade.dart';
import '../services/dummy_data.dart';
import '../widgets/cricket_score_card.dart';
import '../widgets/trade_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Trade> _trades;
  late List<CricketMatch> _matches;
  int _selectedSportIndex = 0;
  final List<String> _sportCategories = ['Cricket', 'Kabaddi', 'Football'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _trades = DummyData.getDummyTrades();
    _matches = DummyData.getDummyCricketMatches();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SPORT'S TRADE"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'TRADES'),
            Tab(text: 'LIVE'),
            Tab(text: 'FANTASY'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Trades Tab
          _buildTradesTab(),

          // Live Matches Tab
          _buildMatchesTab(true),

          // Fantasy Tab (replacing Upcoming)
          _buildFantasyTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to create a new trade
          _showCreateTradeDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateTradeDialog() {
    final questionController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedMatchId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Trade'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  hintText: 'Enter a yes/no question',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description for this trade',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              StatefulBuilder(builder: (context, setState) {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Match',
                  ),
                  value: selectedMatchId,
                  items: _matches
                      .map((match) => DropdownMenuItem(
                            value: match.id,
                            child: Text('${match.team1} vs ${match.team2}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMatchId = value;
                    });
                  },
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  selectedMatchId != null) {
                // Create a new trade
                final newTrade = Trade(
                  id: (_trades.length + 1).toString(),
                  question: questionController.text,
                  description: descriptionController.text,
                  createdAt: DateTime.now(),
                  expiresAt: DateTime.now().add(const Duration(hours: 24)),
                  status: TradeStatus.active,
                  result: TradeResult.pending,
                  yesCount: 0,
                  noCount: 0,
                  category: 'Cricket',
                  matchId: selectedMatchId!,
                );

                setState(() {
                  _trades.add(newTrade);
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Trade created successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                // Show error
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Widget _buildTradesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Live Cricket Score Section
        if (_matches.any((match) => match.isLive))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Live Scores',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _matches
                      .where((match) => match.isLive)
                      .map((match) => CricketScoreCard(match: match))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
            ],
          ),

        // Active Trades Section
        const Text(
          'Active Trades',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ..._trades
            .where((trade) => trade.status == TradeStatus.active)
            .map((trade) => TradeCard(trade: trade))
            .toList(),

        const SizedBox(height: 16),
        const Divider(),

        // Completed Trades Section
        const Text(
          'Completed Trades',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ..._trades
            .where((trade) => trade.status == TradeStatus.completed)
            .map((trade) => TradeCard(trade: trade))
            .toList(),
      ],
    );
  }

  Widget _buildMatchesTab(bool isLive) {
    final filteredMatches = isLive
        ? _matches.where((match) => match.isLive).toList()
        : _matches.where((match) => match.isUpcoming).toList();

    return filteredMatches.isEmpty
        ? Center(
            child: Text(
              isLive ? 'No live matches at the moment' : 'No upcoming matches',
              style: const TextStyle(fontSize: 16),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredMatches.length,
            itemBuilder: (context, index) {
              return CricketScoreCard(
                match: filteredMatches[index],
                expanded: true,
              );
            },
          );
  }

  Widget _buildFantasyTab() {
    return Column(
      children: [
        // Sport category selector
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _sportCategories.length,
              (index) => _buildSportCategoryButton(index),
            ),
          ),
        ),

        // Sport content
        Expanded(
          child: _buildSportContent(_selectedSportIndex),
        ),
      ],
    );
  }

  Widget _buildSportCategoryButton(int index) {
    final isSelected = index == _selectedSportIndex;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedSportIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _sportCategories[index],
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSportContent(int sportIndex) {
    // For demo purposes, we'll show different content based on the selected sport
    switch (sportIndex) {
      case 0: // Cricket
        return _buildCricketFantasy();
      case 1: // Kabaddi
        return _buildKabaddiFantasy();
      case 2: // Football
        return _buildFootballFantasy();
      default:
        return const Center(child: Text('Select a sport'));
    }
  }

  Widget _buildCricketFantasy() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFantasyCard(
          'IPL Fantasy League',
          'Create your dream team and compete with friends',
          'assets/ipl.png',
          Colors.blue,
        ),
        _buildFantasyCard(
          'World Cup Fantasy',
          'Pick players from around the world',
          'assets/worldcup.png',
          Colors.green,
        ),
        _buildFantasyCard(
          'Test Match Special',
          'Long format fantasy cricket',
          'assets/test.png',
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildKabaddiFantasy() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFantasyCard(
          'Pro Kabaddi League',
          'Select your favorite raiders and defenders',
          'assets/pkl.png',
          Colors.orange,
        ),
        _buildFantasyCard(
          'National Kabaddi',
          'Support your state teams',
          'assets/national.png',
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildFootballFantasy() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFantasyCard(
          'Premier League Fantasy',
          'Build your dream EPL team',
          'assets/epl.png',
          Colors.deepPurple,
        ),
        _buildFantasyCard(
          'Champions League',
          'Compete with the best clubs in Europe',
          'assets/ucl.png',
          Colors.indigo,
        ),
        _buildFantasyCard(
          'ISL Fantasy',
          'Indian Super League fantasy football',
          'assets/isl.png',
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildFantasyCard(
      String title, String description, String imagePath, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title coming soon!'),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  _getIconForSport(_selectedSportIndex),
                  size: 60,
                  color: color,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Join ${1000 + (_selectedSportIndex * 500)} players',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title coming soon!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Join'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSport(int sportIndex) {
    switch (sportIndex) {
      case 0:
        return Icons.sports_cricket;
      case 1:
        return Icons.sports_kabaddi;
      case 2:
        return Icons.sports_soccer;
      default:
        return Icons.sports;
    }
  }
}
