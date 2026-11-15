import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, String>> bukuData = [
  {
    'title': 'Dragon Ball',
    'image': 'https://upload.wikimedia.org/wikipedia/en/c/c9/DB_Tank%C5%8Dbon.png?utm_source=en.wikipedia.org&utm_campaign=index&utm_content=original',
  },
  {
    'title': 'Naruto Shippuden',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk5Krs3gEX0hyJGI6A7P7HTDHSKnGZH6wOiOj8R-JDQg&s=10',
  },
  {
    'title': 'One Piece',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ34Vjx4iYDxD_I_PFj-8jPII81plyHaSeIhDAUNdLMBQ&s=10',
  },
  {
    'title': 'Bleach',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9IobjfWpxEcBdDo9OUn1yUevmVTDb5HIsKQZGkXT-IA&s=10',
  },
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Buku',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Data Buku',
            style: TextStyle(fontWeight: .bold, fontSize: 30),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.cyanAccent,
          centerTitle: true,
          leading: Icon(Icons.book, size: 30),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'List View'),
              Tab(icon: Icon(Icons.grid_on), text: 'Grid View'),
            ],
          ),
        ),
        body: TabBarView(children: [buildListView(), buildGridView()]),
      ),
    );
  }
}

Widget buildListView() {
  return ListView.builder(
    itemCount: bukuData.length,
    itemBuilder: (context, index) {
      final item = bukuData[index];
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: ListTile(
          leading: Image.network(
            item['image']!,
            height: 200,
            fit: BoxFit.cover,
          ),
          title: Text(item['title']!),
        ),
      );
    },
  );
}

Widget buildGridView() {
  return GridView.builder(
    itemCount: bukuData.length,
    padding: EdgeInsets.all(12),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      final item = bukuData[index];
      return Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(width: 50, height: 100, item['image']!),
            ),
            Padding(
              padding: EdgeInsets.all(9),
              child: Text(
                item['title']!,
                style: TextStyle(fontWeight: .bold, fontSize: 10),
                textAlign: .center,
              ),
            ),
          ],
        ),
      );
    },
  );
}
