import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/profile_data.dart';

class ProfileData {
  final String name;
  final String position;
  final String avatarUrl;
  final List<TileData> tiles;

//Constructor
  ProfileData(
      {required this.name,
      required this.position,
      required this.tiles,
      required this.avatarUrl});
}

class TileData {
  final IconData icon;
  final String title;
  final String value;

  TileData({required this.icon, required this.title, required this.value});
}

void main() {
  runApp(const MaterialApp());
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.profileData});
  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    //Sample Data
    return Scaffold(
      appBar: AppBar(
        title: const Text('CADT Student Profile'),
      ),
      body: ProfileApp(profileData: ronanProfile),
    );
  }
}
  // Profile App Widget
class ProfileApp extends StatelessWidget {
  final ProfileData profileData;

  const ProfileApp({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileData.avatarUrl),
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
          ...profileData.tiles.map((tile) => ListTile(
                leading: Icon(tile.icon),
                title: Text(tile.title),
                subtitle: Text(tile.value),
              )),
        ],
      ),
    );
  }
}