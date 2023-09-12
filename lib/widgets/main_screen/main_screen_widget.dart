import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  static const List<Widget> _widgetOption = <Widget>[
    Text('Домашняя'),
    Text('Настройки'),
    Text('Профиль'),
  ];

  void onSelectTab(int index){
    if(_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
      ),
      body: Center(child: _widgetOption[_selectedTab],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Домашняя'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Настроки'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль')
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
