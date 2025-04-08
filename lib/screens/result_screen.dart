import 'package:flutter/material.dart';
import 'dart:math';
import '../models/trade.dart';

class ResultScreen extends StatefulWidget {
  final Trade trade;
  final bool selectedYes;

  const ResultScreen({
    Key? key,
    required this.trade,
    required this.selectedYes,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late bool _isWin;
  late int _amount;

  @override
  void initState() {
    super.initState();
    
    // Randomly determine win/loss for demo purposes
    // In a real app, this would be based on actual results
    final random = Random();
    _isWin = random.nextBool();
    
    // Generate a random amount between 10 and 100
    _amount = random.nextInt(91) + 10;
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Result'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _isWin ? Colors.green.shade50 : Colors.red.shade50,
              _isWin ? Colors.green.shade100 : Colors.red.shade100,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Trade question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.trade.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Your prediction
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Your prediction: ${widget.selectedYes ? 'YES' : 'NO'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.selectedYes ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Result animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _isWin ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_isWin ? Colors.green : Colors.red).withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    _isWin ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Result text
            Text(
              _isWin ? 'You Won!' : 'You Lost',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _isWin ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            
            // Amount or message
            Text(
              _isWin ? 'Rs $_amount credited to your account' : 'Better luck next time',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            
            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      child: const Text('Back to Trades'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate back to home and reset to the trades tab
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Home'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

