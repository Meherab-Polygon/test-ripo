import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/dummy_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<User> _users;
  late User _currentUser;
  int _selectedUserIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _users = DummyData.getDummyUsers();
    _currentUser = _users[_selectedUserIndex];
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _switchUser(int index) {
    setState(() {
      _selectedUserIndex = index;
      _currentUser = _users[_selectedUserIndex];
    });
    Navigator.pop(context);
  }

  void _showAddProfileDialog() {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter a unique username',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
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
              if (nameController.text.isNotEmpty && 
                  usernameController.text.isNotEmpty && 
                  emailController.text.isNotEmpty) {
                setState(() {
                  _users.add(User(
                    id: (_users.length + 1).toString(),
                    name: nameController.text,
                    username: usernameController.text,
                    email: emailController.text,
                    profileImage: 'https://via.placeholder.com/150',
                  ));
                  _selectedUserIndex = _users.length - 1;
                  _currentUser = _users[_selectedUserIndex];
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showSignupDialog() {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Up'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter a unique username',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter a strong password',
                ),
                obscureText: true,
              ),
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
              if (nameController.text.isNotEmpty && 
                  usernameController.text.isNotEmpty && 
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  _users.add(User(
                    id: (_users.length + 1).toString(),
                    name: nameController.text,
                    username: usernameController.text,
                    email: emailController.text,
                    profileImage: 'https://via.placeholder.com/150',
                  ));
                  _selectedUserIndex = _users.length - 1;
                  _currentUser = _users[_selectedUserIndex];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account created successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'switch') {
                _showUserSwitchDialog();
              } else if (value == 'add') {
                _showAddProfileDialog();
              } else if (value == 'signup') {
                _showSignupDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'switch',
                child: Text('Switch Profile'),
              ),
              const PopupMenuItem(
                value: 'add',
                child: Text('Add Profile'),
              ),
              const PopupMenuItem(
                value: 'signup',
                child: Text('Mock Signup'),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'PROFILE'),
            Tab(text: 'TRADES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Profile Tab
          _buildProfileTab(),
          
          // Trades Tab
          _buildTradesTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
  
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(_currentUser.profileImage),
          ),
          const SizedBox(height: 16),
          Text(
            _currentUser.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '@${_currentUser.username}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('Balance', '₹${_currentUser.balance}'),
                  _buildStatColumn('Active Trades', _currentUser.activeTrades.length.toString()),
                  _buildStatColumn('Completed', _currentUser.completedTrades.length.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const ListTile(
            leading: Icon(Icons.history),
            title: Text('Trade History'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & Support'),
            trailing: Icon(Icons.chevron_right),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to sign in screen
              Navigator.pushReplacementNamed(context, '/signin');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTradesTab() {
    return Center(
      child: Text(
        'Trade history will appear here',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }
  
  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  void _showUserSwitchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Switch Profile'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _users.length,
            itemBuilder: (context, index) {
              final user = _users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImage),
                ),
                title: Text(user.name),
                subtitle: Text('@${user.username}'),
                selected: index == _selectedUserIndex,
                onTap: () => _switchUser(index),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

