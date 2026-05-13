import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final double responsiveWidth = MediaQuery.sizeOf(context).width * 0.8;
    final double finalWidth = responsiveWidth > 400 ? 400 : responsiveWidth;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: finalWidth,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_library, size: 80, color: Colors.green),
                const SizedBox(height: 32),
                Text('Библиотеки Минска', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 32),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Пароль', border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).login(
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Войти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}