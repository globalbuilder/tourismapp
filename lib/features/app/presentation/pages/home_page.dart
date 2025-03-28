import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_frontend/features/accounts/bloc/auth_bloc.dart';
import 'package:tourism_frontend/core/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Some dummy attractions
  final List<String> _dummyAttractions = [
    "Eiffel Tower (dummy)",
    "Colosseum (dummy)",
    "Grand Mosque (dummy)",
    "Great Wall (dummy)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // show a search or do something
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  Navigator.pushNamed(context, '/profile');
                  break;
                case 'favorites':
                  Navigator.pushNamed(context, '/favorites');
                  break;
                case 'settings':
                  Navigator.pushNamed(context, '/settings');
                  break;
                case 'logout':
                  context.read<AuthBloc>().add(AuthLogoutEvent());
                  Navigator.pushReplacementNamed(context, '/login');
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'profile', child: Text("Profile")),
              const PopupMenuItem(value: 'favorites', child: Text("Favorites")),
              const PopupMenuItem(value: 'settings', child: Text("Settings")),
              const PopupMenuItem(value: 'logout', child: Text("Logout")),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _dummyAttractions.length,
        itemBuilder: (context, index) {
          final title = _dummyAttractions[index];
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(title),
              subtitle: const Text("Dummy location, rating, etc."),
              onTap: () {
                Navigator.pushNamed(context, '/attraction-details', arguments: 999);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() => _currentIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, '/map-screen');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/category-list');
          }
        },
      ),
    );
  }
}
