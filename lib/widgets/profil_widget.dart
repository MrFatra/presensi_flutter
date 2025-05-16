import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? image;
  final String? name;
  final String? id;
  final String? studentClass;

  const ProfileHeader(
      {this.id, this.name, this.studentClass, this.image, super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: image != null ? AssetImage(image!) : null,
      ),
      title: Text(
        name ?? '-',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        studentClass ?? '-',
        style: TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.logout, color: Colors.white),
    );
  }
}
