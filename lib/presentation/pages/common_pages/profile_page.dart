import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/common_pages/login_page.dart';
import 'package:task_sync/utils/platform_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Профиль пользователя', style: TextStyle(color: Colors.white)),
            backgroundColor: lightPrimary,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 800),
              child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/avatar_placeholder.png'), // замените на NetworkImage если нужно
        ),
        const SizedBox(height: 16),
        const Text('Тестовый Пользователь', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('email@example.com'),
        const SizedBox(height: 24),
        _buildInfoCard(),
        const SizedBox(height: 16),
        _buildActions()
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/avatar_placeholder.png'),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Имя пользователя', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('email@example.com'),
              const SizedBox(height: 24),
              _buildInfoCard(),
              const SizedBox(height: 16),
              _buildActions()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            InfoRow(label: 'Роль', value: 'Разработчик'),
            InfoRow(label: 'Проектов', value: '3'),
            InfoRow(label: 'Задач', value: '14'),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // переход к редактированию профиля
          },
          icon: const Icon(Icons.edit),
          label: const Text('Редактировать'),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const LoginPage(),
              ),
            );
          },
          icon: const Icon(Icons.logout),
          label: const Text('Выйти'),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
