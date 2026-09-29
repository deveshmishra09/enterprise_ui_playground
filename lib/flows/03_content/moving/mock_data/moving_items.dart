import 'package:enterprise_ui_playground/flows/03_content/moving/constants/product_description_string.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/constants/product_price.dart';

class MovingItem {
  const MovingItem({
    required this.imagePath,
    required this.price,
    required this.description,
  });

  final String imagePath;
  final double price;
  final String description;
}

const List<MovingItem> movingItems = <MovingItem>[
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/bread.jpg',
    price: ProductPrice.breadPrice,
    description: ProductDescriptionString.breadDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/doritos.jpg',
    price: ProductPrice.doritosPrice,
    description: ProductDescriptionString.doritosDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/chocolate_cookies.jpg',
    price: ProductPrice.chocolateCookiesPrice,
    description: ProductDescriptionString.chocolateCookiesDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/dairy_milk.jpg',
    price: ProductPrice.dairyMilk,
    description: ProductDescriptionString.dairyMilkDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/ferrero_rocher.jpg',
    price: ProductPrice.ferreroRocher,
    description: ProductDescriptionString.ferreroRocherDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/kurkure_chilli_chatka.jpg',
    price: ProductPrice.kurkureChilliChatka,
    description: ProductDescriptionString.kurkureChilliChatkaDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/kurkure_masala_munch.jpg',
    price: ProductPrice.kurkureMasalaMunch,
    description: ProductDescriptionString.kurkureMasalaMunchDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/puffcorn.jpg',
    price: ProductPrice.puffcorn,
    description: ProductDescriptionString.puffcornDescription,
  ),
  MovingItem(
    imagePath: 'lib/flows/03_content/moving/mock_data/unibic_choco_chip.jpg',
    price: ProductPrice.unibicChocoChip,
    description: ProductDescriptionString.unibicChocoChipDescription,
  ),
];