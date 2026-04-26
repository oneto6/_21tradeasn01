import 'package:_21tradeasn01/core/model/stock.dart';
import 'package:uuid/v4.dart';

class WatchlistRepo {
  List<Stock> list() {
    final uuid = UuidV4();
    final list = [
      Stock(uuid.generate(), "Reliance Industries", 1327.80, 0.008),
      Stock(uuid.generate(), "TCS", 2396.90, -0.0495),
      Stock(uuid.generate(), "HDFC Bank", 784.85, 0.006),
      Stock(uuid.generate(), "Infosys", 1154.45, -0.0709),
    ];

    return list;
  }
}
