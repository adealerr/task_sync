import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/pages_narrow/chat_detail_narrow_page.dart';

class ChatsNarrowPage extends StatefulWidget {
  const ChatsNarrowPage({super.key});

  @override
  State<ChatsNarrowPage> createState() => _ChatsNarrowPageState();
}

class _ChatsNarrowPageState extends State<ChatsNarrowPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<ChatItem> _allChats = [
    ChatItem(name: 'Алексей Смирнов', message: 'Вы: возьми в работу, пожалуйста', time: '20:19'),
    ChatItem(name: 'Ирина Васильева', message: 'Назовите вашу должность.', time: '20:18'),
    ChatItem(name: 'Банк Восточный', message: 'Транзакция была обработана', time: '20:05', unreadCount: 3),
    ChatItem(name: 'Ольга Кузнецова', message: 'вы из отдела Алексея?', time: '19:56', unreadCount: 1),
    ChatItem(name: 'Дмитрий Иванов', message: '…пойду своим тёмным путём', time: '17:52'),
    ChatItem(name: 'Отдел разработки', message: 'Вы: 🚗 Уже еду', time: '17:51'),
    ChatItem(name: 'Мария Соколова', message: 'Я упала в обморок…', time: '11:27'),
    ChatItem(name: 'Служба поддержки', message: 'Инспектор Новиков: 🤔', time: '11:11'),
    ChatItem(name: 'Павел Орлов', message: 'Да, слушаю?', time: '14:30'),
    ChatItem(name: 'Ирина Восточная', message: 'Привет', time: '20:18'),
    ChatItem(name: 'Петр Иваненко', message: 'Здравствуйте', time: '20:05', unreadCount: 1),
    ChatItem(name: 'Ирина Петрова', message: 'вы передали отчет?', time: '19:56', unreadCount: 4),
    ChatItem(name: 'Алиса Чудова', message: 'подскажи по статусу задачи, пожалуйста', time: '17:52'),
    ChatItem(name: 'Максим Ревва', message: 'что могу взять в работу?', time: '17:51'),
    ChatItem(name: 'Игорь Бармалей', message: 'как тебе новый дизайн?', time: '11:27'),
  ];
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredChats = _allChats.where((chat) {
      final query = _searchQuery.toLowerCase();
      return chat.name.toLowerCase().contains(query) ||
          chat.message.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: lightBackground),
          decoration: const InputDecoration(
            hintText: 'Поиск...',
            hintStyle: TextStyle(color: lightBackgroundTertiary),
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _searchQuery = value),
        )
            : const Text(
          'Чаты',
          style: TextStyle(color: lightBackground),
        ),
        backgroundColor: lightPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
            color: lightBackground,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredChats.length,
        itemBuilder: (context, index) {
          final chat = filteredChats[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailNarrowPage(chatName: chat.name),
                ),
              );
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.webp'),
              radius: 24,
            ),
            title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(chat.message, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(chat.time, style: const TextStyle(fontSize: 12)),
                if (chat.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Поиск'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(hintText: 'Введите имя или сообщение'),
          onChanged: (value) => setState(() => _searchQuery = value),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = _searchController.text);
              Navigator.pop(context);
            },
            child: const Text('Найти'),
          ),
        ],
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });
}
