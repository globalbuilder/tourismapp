import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_frontend/features/accounts/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: () {
              Navigator.pushNamed(context, '/change-password');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is ProfileLoaded) {
            final user = state.user;
            final profile = state.profile;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text("Username: ${user.username}"),
                  Text("Verified: ${user.isVerified}"),
                  Text("Created at: ${user.createdAt}"),
                  const SizedBox(height: 16),
                  Text("Email: ${profile.email ?? 'N/A'}"),
                  Text("Phone: ${profile.phoneNumber ?? 'N/A'}"),
                  Text("DOB: ${profile.dateOfBirth ?? 'N/A'}"),
                  Text("Address: ${profile.address ?? 'N/A'}"),
                  Text("Bio: ${profile.biography ?? 'N/A'}"),
                  Text("Website: ${profile.website ?? 'N/A'}"),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
