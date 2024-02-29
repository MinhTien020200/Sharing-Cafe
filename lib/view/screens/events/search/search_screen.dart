import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> searchHistory = [
    'Năng suất tại nơi làm việc',
    'Lợi ích của thiền',
    'How to Build an Online Business',
    // Add more search history items here
  ];

  void removeFromSearchHistory(String query) {
    setState(() {
      searchHistory.remove(query);
    });
  }

  void removeAllSearchHistory() {
    setState(() {
      searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: kFormFieldColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            decoration: const InputDecoration(
                hintText: 'Tìm kiếm',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
            onChanged: (value) {
              // Update event name
            },
            onSubmitted: (value) {
              setState(() {
                searchHistory.add(value);
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: searchHistory.isNotEmpty,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tìm kiếm trước đó',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => removeAllSearchHistory(),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      searchHistory[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          removeFromSearchHistory(searchHistory[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
