import 'package:flutter/material.dart';
import 'package:flutter_pro/widgets/interactive/background.dart';
import 'package:flutter_pro/widgets/interactive/cached_image.dart';
import 'package:flutter_pro/widgets/interactive/links.dart';
import 'package:flutter_pro/widgets/interactive/return_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/cards_provider.dart';
import '../providers/user_provider.dart';

class LikedCardsScreen extends StatefulWidget {
  const LikedCardsScreen({
    super.key,
  });

  @override
  LikedCardsScreenState createState() => LikedCardsScreenState();
}

class LikedCardsScreenState extends State<LikedCardsScreen> {
  final String selectedBackground = UserData.instance.selectedBackground;
  final int backgroundsCount = 9;
  bool isAnimationEnabled = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<LikedCatsProvider>(context, listen: false);
    await provider.loadCats();
  }

  @override
  Widget build(final BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    Provider.of<LikedCatsProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Background(selectedBackground: selectedBackground),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 64 + padding.top, 8, 90),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(125),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (final value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Consumer<LikedCatsProvider>(
                      builder: (final context, final provider, final child) {
                        final filteredCats =
                            provider.filter(searchQuery.toLowerCase());

                        if (filteredCats.isEmpty) {
                          return const Center(
                            child: Text(
                                'Your liked favourites will appear here...'),
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredCats.length,
                          itemBuilder: (final context, final index) {
                            final image = filteredCats[index];
                            return SizedBox(
                              height: 90,
                              child: Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 90,
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 0, 32, 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImageWithFallback(
                                        url: image.url,
                                        height: 90,
                                        width: 120,
                                      ),
                                    ),
                                  ),
                                  // Текстовая часть с кнопкой
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          image.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Liked: ${DateFormat('dd MM yyyy').format(image.date)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    onPressed: () => provider.removeCat(image),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ReturnButton(),
          const Links(),
        ],
      ),
    );
  }
}
