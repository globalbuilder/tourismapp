import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_frontend/features/accounts/bloc/profile_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPassCtrl = TextEditingController();
  final _newPass1Ctrl = TextEditingController();
  final _newPass2Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          } else if (state is ProfileLoaded) {
            // success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password changed successfully!")),
            );
            Navigator.pop(context); // go back
          }
        },
        builder: (context, state) {
          final loading = state is ProfileLoading;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _oldPassCtrl,
                  decoration: const InputDecoration(labelText: "Old Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPass1Ctrl,
                  decoration: const InputDecoration(labelText: "New Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPass2Ctrl,
                  decoration: const InputDecoration(labelText: "Confirm New Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: loading ? null : _changePassword,
                  child: loading ? const CircularProgressIndicator() : const Text("Change Password"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _changePassword() {
    context.read<ProfileBloc>().add(
      ChangePasswordEvent(
        oldPassword: _oldPassCtrl.text,
        newPassword1: _newPass1Ctrl.text,
        newPassword2: _newPass2Ctrl.text,
      ),
    );
  }
}
