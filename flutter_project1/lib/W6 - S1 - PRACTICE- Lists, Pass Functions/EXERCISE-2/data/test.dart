import 'package:flutter/material.dart';

// Models
class ProfileData {
  final String name;
  final String position;
  final String? avatarUrl;
  final List<TileData> titles;

  ProfileData({
    required this.name,
    required this.position,
    this.avatarUrl,
    required this.titles,
  });
}

class TileData {
  final IconData icon;
  final String title;
  final String data;

  TileData({
    required this.icon,
    required this.title,
    required this.data,
  });
}

// Main App
void main() {
  runApp(const MaterialApp(home: ProfileScreen()));
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final profile = ProfileData(
      name: 'Ronan OGOR',
      position: 'Flutter Developer',
      avatarUrl: null, // Provide an image URL here if needed
      titles: [
        TileData(icon: Icons.phone, title: 'Phone Number', data: '+123 456 789'),
        TileData(icon: Icons.location_on, title: 'Address', data: '123 Street Name'),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CADT Student Profile'),
      ),
      body: ProfileApp(profileData: profile),
    );
  }
}

// Profile App Widget
class ProfileApp extends StatelessWidget {
  final ProfileData profileData;

  const ProfileApp({Key? key, required this.profileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: profileData.avatarUrl != null
                ? NetworkImage(profileData.avatarUrl!)
                : null,
            child: profileData.avatarUrl == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
          const SizedBox(height: 10),
          Text(
            profileData.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            profileData.position,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ...profileData.titles.map((tile) => ListTile(
                leading: Icon(tile.icon),
                title: Text(tile.title),
                subtitle: Text(tile.data),
              )),
        ],
      ),
    );
  }
}
