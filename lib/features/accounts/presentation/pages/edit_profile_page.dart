import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_frontend/features/accounts/bloc/profile_bloc.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state is ProfileLoaded) {
      final loadedState = profileBloc.state as ProfileLoaded;
      final user = loadedState.user;
      final profile = loadedState.profile;

      _firstNameCtrl.text = user.firstName ?? '';
      _lastNameCtrl.text = user.lastName ?? '';
      _emailCtrl.text = profile.email ?? '';
      _phoneCtrl.text = profile.phoneNumber ?? '';
      _addressCtrl.text = profile.address ?? '';
      _bioCtrl.text = profile.biography ?? '';
      _websiteCtrl.text = profile.website ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          } else if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated")),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: _firstNameCtrl,
                  decoration: const InputDecoration(labelText: "First Name"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameCtrl,
                  decoration: const InputDecoration(labelText: "Last Name"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressCtrl,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _bioCtrl,
                  decoration: const InputDecoration(labelText: "Biography"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _websiteCtrl,
                  decoration: const InputDecoration(labelText: "Website"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text("Update"),
                  onPressed: _updateAll,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateAll() {
    final profileBloc = context.read<ProfileBloc>();
    // Update user
    profileBloc.add(UpdateUserEvent(
      firstName: _firstNameCtrl.text,
      lastName: _lastNameCtrl.text,
    ));
    // Then update profile
    profileBloc.add(UpdateProfileEvent(
      email: _emailCtrl.text,
      phoneNumber: _phoneCtrl.text,
      address: _addressCtrl.text,
      biography: _bioCtrl.text,
      website: _websiteCtrl.text,
    ));
  }
}
