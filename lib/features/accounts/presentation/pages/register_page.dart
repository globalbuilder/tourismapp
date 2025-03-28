import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_frontend/features/accounts/bloc/auth_bloc.dart';
import 'package:tourism_frontend/core/widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _password1Ctrl = TextEditingController();
  final _password2Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthUnauthenticated) {
            // Registration success => remain unauth or prompt success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration successful!")),
            );
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 16),
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
                  controller: _password1Ctrl,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _password2Ctrl,
                  decoration: const InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  title: "Register",
                  loading: loading,
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthRegisterEvent(
                        username: _usernameCtrl.text,
                        firstName: _firstNameCtrl.text,
                        lastName: _lastNameCtrl.text,
                        password1: _password1Ctrl.text,
                        password2: _password2Ctrl.text,
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
