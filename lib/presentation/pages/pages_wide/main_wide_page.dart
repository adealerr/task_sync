import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/common_pages/create_task_page.dart';
import 'package:task_sync/presentation/pages/common_pages/profile_page.dart';
import 'package:task_sync/presentation/pages/common_pages/report_page.dart';
import 'package:task_sync/presentation/pages/pages_wide/tasks_wide_view.dart';

class MainWidePage extends StatefulWidget {
  const MainWidePage({super.key});

  @override
  State<MainWidePage> createState() => _MainWidePageState();
}

class _MainWidePageState extends State<MainWidePage> {
  final List<Task> tasks = [
    const Task(id: 1, title: 'Сделать авторизацию', assignee: 'Иван Иванов', status: TaskStatus.open),
    const Task(id: 2, title: 'Добавить чат', assignee: 'Мария Смирнова', status: TaskStatus.inProgress),
    const Task(id: 3, title: 'Тестирование задач', assignee: 'Олег Кузнецов', status: TaskStatus.done),
  ];

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
  String _searchQuery = '';
  ChatItem? _selectedChat;
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final filteredChats = _allChats.where((chat) {
      final query = _searchQuery.toLowerCase();
      return chat.name.toLowerCase().contains(query) || chat.message.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      body: Row(
        children: [
          // Вертикальное меню
          NavigationRail(
            backgroundColor: lightPrimary,
            selectedIndex: _selectedTabIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                selectedIcon: Icon(Icons.task, color: lightButtonHover),
                indicatorColor: lightText,
                icon: Icon(
                  Icons.task,
                  color: lightBackground,
                ),
                label: Text(
                  'Задачи',
                  style: TextStyle(
                    color: lightBackground,
                  ),
                ),
              ),
              NavigationRailDestination(
                selectedIcon: Icon(Icons.chat, color: lightButtonHover),
                icon: Icon(Icons.chat, color: lightBackground),
                label: Text(
                  'Чаты',
                  style: TextStyle(
                    color: lightBackground,
                  ),
                ),
              ),
              NavigationRailDestination(
                selectedIcon: Icon(Icons.person, color: lightButtonHover),
                icon: Icon(Icons.person, color: lightBackground),
                label: Text(
                  'Профиль',
                  style: TextStyle(
                    color: lightBackground,
                  ),
                ),
              ),
              NavigationRailDestination(
                selectedIcon: Icon(Icons.analytics, color: lightButtonHover),
                icon: Icon(Icons.analytics, color: lightBackground),
                label: Text(
                  'Отчетность',
                  style: TextStyle(
                    color: lightBackground,
                  ),
                ),
              ),
            ],
          ),

          if (_selectedTabIndex == 1) ...[
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: const InputDecoration(
                        hintText: 'Поиск...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredChats.length,
                      itemBuilder: (context, index) {
                        final chat = filteredChats[index];
                        return ListTile(
                          title: Text(chat.name),
                          subtitle: Text(chat.message),
                          trailing: Text(chat.time),
                          selected: _selectedChat == chat,
                          onTap: () => setState(() => _selectedChat = chat),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _selectedChat == null
                  ? const Center(
                      child: Text(
                        'Выберите чат, чтобы начать общение',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ChatPanel(chat: _selectedChat!),
            ),
          ] else if (_selectedTabIndex == 0)
            Expanded(child: TasksWideView(tasks: tasks))
          else if (_selectedTabIndex == 2)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      top: 24,
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Text('Имя пользователя', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('email@example.com'),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  InfoRow(label: 'Роль', value: 'Разработчик'),
                                  InfoRow(label: 'Проектов', value: '3'),
                                  InfoRow(label: 'Задач', value: '14'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
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
                                // выход из профиля
                              },
                              icon: const Icon(Icons.logout),
                              label: const Text('Выйти'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else if (_selectedTabIndex == 3)
            const Expanded(child: ReportView()),
        ],
      ),
      floatingActionButton: _selectedTabIndex == 0
          ? FloatingActionButton.extended(
              backgroundColor: lightPrimary,
              onPressed: () async {
                final newTask = await showDialog<Task?>(
                  context: context,
                  builder: (context) => const AlertDialog(
                      title: Text(
                        'Создание задачи',
                        style: TextStyle(
                          color: lightText,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(24),
                      content: CreateTaskView()),
                );

                if (newTask == null) {
                  return;
                }

                setState(() {
                  tasks.add(newTask);
                });
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Создать задачу', style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }
}
/*class ChatPanel extends StatelessWidget {
  final ChatItem chat;

  const ChatPanel({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text(chat.name), centerTitle: false,),
        const Expanded(
          child: Center(
            child: Text('Здесь будут сообщения...'),
          ),
        ),
      ],
    );
  }
}*/

class ChatPanel extends StatefulWidget {
  final ChatItem chat;

  const ChatPanel({super.key, required this.chat});

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        content: text,
        isMe: true,
        time: TimeOfDay.now().format(context),
      ));

      _messages = _messages.reversed.toList();
      _messageController.clear();
    });

    // Прокрутка вниз после отправки
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(widget.chat.name),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: msg.isMe ? Colors.blue[200] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(msg.content, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(msg.time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Введите сообщение...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final int? unreadCount;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount,
  });
}

class Message {
  final String content;
  final String time;
  final bool isMe;

  Message({
    required this.content,
    required this.time,
    required this.isMe,
  });
}
