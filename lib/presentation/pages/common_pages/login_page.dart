import 'package:flutter/material.dart';
import 'package:task_sync/data/models/enum/app_platform_type.dart';
import 'package:task_sync/presentation/pages/pages_narrow/main_narrow_page.dart';
import 'package:task_sync/presentation/pages/pages_wide/main_wide_page.dart';
import 'package:task_sync/utils/platform_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = PlatformHelper.runningPlatform.isDesktop;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 400 : double.infinity,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Вход в аккаунт',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 24),
                const _CustomInputField(
                  label: 'Логин',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                const _CustomInputField(
                  label: 'Пароль',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => isDesktop ? const MainWidePage() : const MainNarrowPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Войти',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomInputField extends StatefulWidget {
  final String label;
  final bool obscureText;

  const _CustomInputField({
    required this.label,
    required this.obscureText,
  });

  @override
  State<_CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<_CustomInputField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
              )
            : null,
      ),
    );
  }
}
