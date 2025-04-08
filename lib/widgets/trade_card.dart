import 'package:flutter/material.dart';
import '../models/trade.dart';
import '../screens/result_screen.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;
  
  const TradeCard({
    Key? key,
    required this.trade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = trade.status == TradeStatus.active;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    trade.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isActive ? 'Active' : 'Completed',
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              trade.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    context,
                    'YES',
                    trade.yesPercentage.toInt(),
                    isActive,
                    trade.result == TradeResult.yes,
                    Colors.green,
                    true, // isYes
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildOptionButton(
                    context,
                    'NO',
                    trade.noPercentage.toInt(),
                    isActive,
                    trade.result == TradeResult.no,
                    Colors.red,
                    false, // isYes
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expires: ${isActive ? _formatTimeRemaining(trade.expiresAt) : "Ended"}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${trade.yesCount + trade.noCount} trades',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOptionButton(
    BuildContext context,
    String label,
    int percentage,
    bool isActive,
    bool isSelected,
    Color color,
    bool isYes,
  ) {
    return InkWell(
      onTap: isActive ? () {
        // Navigate to result screen with appropriate parameters
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              trade: trade,
              selectedYes: isYes,
            ),
          ),
        );
      } : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? color : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatTimeRemaining(DateTime expiresAt) {
    final duration = expiresAt.difference(DateTime.now());
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }
}

