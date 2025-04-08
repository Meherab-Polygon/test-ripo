import 'package:flutter/material.dart';
import '../models/cricket_match.dart';

class CricketScoreCard extends StatelessWidget {
  final CricketMatch match;
  final bool expanded;
  
  const CricketScoreCard({
    Key? key,
    required this.match,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: expanded 
          ? const EdgeInsets.only(bottom: 16) 
          : const EdgeInsets.only(right: 16, bottom: 8),
      child: Container(
        width: expanded ? double.infinity : 280,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match.isLive ? 'LIVE' : (match.isUpcoming ? 'UPCOMING' : 'COMPLETED'),
                  style: TextStyle(
                    color: match.isLive ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                if (match.isUpcoming)
                  Text(
                    _formatDateTime(match.startTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTeamRow(match.team1, match.team1Flag, match.score1, match.overs1),
            const SizedBox(height: 8),
            _buildTeamRow(match.team2, match.team2Flag, match.score2, match.overs2),
            if (match.isCompleted && expanded)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  match.result,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            if (expanded && match.isLive)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.red, size: 12),
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View Trades'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTeamRow(String team, String flagUrl, String score, String overs) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            flagUrl,
            width: 24,
            height: 16,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            team,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (score.isNotEmpty)
          Text(
            score,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (overs.isNotEmpty)
          Text(
            ' ($overs)',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
  
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
      return 'Today, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (dateTime.day == now.day + 1 && dateTime.month == now.month && dateTime.year == now.year) {
      return 'Tomorrow, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

