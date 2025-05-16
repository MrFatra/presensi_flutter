import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: const CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage('assets/images/gambar.png'),
      ),
      title: const Text(
        'Nama Siswa',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Nomor Induk Siswa - KELAS',
        style: TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.logout, color: Colors.white),
    );
  }
}
