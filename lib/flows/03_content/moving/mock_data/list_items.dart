import 'package:enterprise_ui_playground/flows/03_content/moving/constants/list_string.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/moving_items.dart';

class ListItem {
  ListItem({
    required this.listName,
    List<MovingItem>? items,
  }) : items = items ?? <MovingItem>[];

  final String listName;
  final List<MovingItem> items;
}

final List<ListItem> listItems = <ListItem>[
  ListItem(
    listName: ListString.list1,
    items: List<MovingItem>.from(movingItems),
  ),
];
