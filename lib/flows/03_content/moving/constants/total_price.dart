import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/moving_items.dart';

double calculateTotalPrice(List<MovingItem> items) {
	return items.fold<double>(
		0,
		(total, item) => total + item.price,
	);
}
