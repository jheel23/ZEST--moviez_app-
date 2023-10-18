import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/API/serach_api.dart';
import 'package:moviez_app/widgets/custom/custom_search_card.dart';

enum SortingMenuOptions { relevance, distance, price, ratings }

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSort = false;
  Future<void> _searchMovies(String query) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          CupertinoActivityIndicator(
            animating: true,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            width: 20,
          ),
          const Text('Loading...'),
        ],
      ),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 3),
    ));
    await ref.read(searchProvider.notifier).searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(searchProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        onPopInvoked: (_) {
          _searchController.clear();
          ref.read(searchProvider.notifier).clearList();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    _searchMovies(value);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),
                      hintText: 'Search for movies, tv shows...',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            elevation: 0,
          ),
          body: list.isEmpty
              ? const Center(
                  child: Text('Search for movies, tv shows...',
                      style: TextStyle(color: Colors.white)),
                )
              : Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _isSort = !_isSort;
                                  });
                                },
                                icon: Icon(Icons.sort,
                                    color: _isSort
                                        ? Theme.of(context).primaryColor
                                        : Colors.white),
                                label: Text(
                                  'Sort By',
                                  style: TextStyle(
                                      color: _isSort
                                          ? Theme.of(context).primaryColor
                                          : Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) =>
                                CustomSearchCard(movie: list[index]),
                          ),
                        ),
                      ],
                    ),
                    if (_isSort)
                      Container(
                        margin: const EdgeInsets.only(top: 60, left: 10),
                        padding: const EdgeInsets.all(10),
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            radioButtonMenu(
                                SortingMenuOptions.relevance,
                                SortingMenuOptions.relevance,
                                (value) {},
                                "Newest"),
                            radioButtonMenu(
                                SortingMenuOptions.distance,
                                SortingMenuOptions.relevance,
                                (value) {},
                                "Popularity"),
                            radioButtonMenu(
                                SortingMenuOptions.price,
                                SortingMenuOptions.relevance,
                                (value) {},
                                "Rating"),
                          ],
                        ),
                      )
                  ],
                ),
        ),
      ),
    );
  }

  RadioListTile<SortingMenuOptions> radioButtonMenu(
      SortingMenuOptions value,
      SortingMenuOptions groupValue,
      void Function(SortingMenuOptions?)? onChanged,
      String title) {
    return RadioListTile.adaptive(
      contentPadding: const EdgeInsets.all(0),
      value: value,
      groupValue: groupValue,
      onChanged: (SortingMenuOptions? value) {},
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
