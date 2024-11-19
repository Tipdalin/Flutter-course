import 'package:flutter/material.dart';
import 'package:w3_s2_practice/W6 - S1 - PRACTICE- Lists, Pass Functions/EXERCISE-2/model/profile_tile_model.dart';

ProfileData ronanProfile = ProfileData(
    name: "Ronan",
    position: "Flutter Developer",
    avatarUrl: 'assets/w4-s2/girl.png',
    tiles: [
      TileData(
          icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
      TileData(
          icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
    ]);
