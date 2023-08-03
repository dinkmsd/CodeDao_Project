import 'package:helper/components/customs/custom_bottom_bar.dart';
import 'package:helper/pages/tab/add_new_word_tab.dart';
import 'package:helper/pages/tab/home_tab.dart';
import 'package:helper/pages/tab/list_new_word_tab.dart';
import 'package:helper/pages/tab/quiz_tab.dart';
import 'package:helper/pages/tab/user_info_tab.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const HomeTab(),
    const SearchTab(),
    const ListNewWordTab(),
    const QuizTab(),
    const UserInfoTab()
  ];

  final List<String> _title = [
    'Home',
    'Search',
    'List New Word',
    'Quiz',
    'User Info'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900])),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title[_selectedIndex]),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: CustomBottomBar(
          items: <CustomBottomBarItem>[
            CustomBottomBarItem(
                icon: const Icon(Icons.home), title: const Text('Home')),
            CustomBottomBarItem(
                icon: const Icon(Icons.search), title: const Text('Search')),
            CustomBottomBarItem(
                icon: const Icon(Icons.list), title: const Text('List')),
            CustomBottomBarItem(
                icon: const Icon(Icons.quiz), title: const Text('Quiz')),
            CustomBottomBarItem(
                icon: const Icon(Icons.person), title: const Text('User'))
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
