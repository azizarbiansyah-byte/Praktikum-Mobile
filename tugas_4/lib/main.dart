import 'package:flutter/material.dart';

import 'api_service.dart';
import 'article_model.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF2F7F6),
      ),
      home: const NewsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> articlesFuture;

  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    articlesFuture = ApiService().fetchArticles();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.offset >= 300) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshArticles() async {
    setState(() => _isRefreshing = true);
    try {
      final articles = await ApiService().fetchArticles();
      if (!mounted) return;
      setState(() {
        articlesFuture = Future.value(articles);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Diperbarui ${TimeOfDay.now().format(context)} • ${articles.length} berita',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memperbarui berita: $e')));
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Paling Anyar'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshArticles,
          ),
        ],
        bottom: _isRefreshing
            ? const PreferredSize(
                preferredSize: Size.fromHeight(3),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: FutureBuilder<List<Article>>(
        future: articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final articles = snapshot.data!;

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article.urlToImage.isNotEmpty)
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: colorScheme.surfaceContainerHighest,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.description,
                                  style: const TextStyle(height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error: ${snapshot.error}\n\nTekan tombol muat ulang untuk mencoba lagi.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Tidak ada berita yang ditemukan.'),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.extended(
              onPressed: _scrollToTop,
              icon: const Icon(Icons.arrow_upward),
              label: const Text('Ke atas'),
            )
          : null,
    );
  }
}
