class Meta {
  late double price;
  late String name;
  Meta(this.name, this.price);
}

//定义商品Item类
class Item extends Meta {
  Item(name, price) : super(name, price);

  // 重载 `加号` 运算符:
  Item operator +(Item item) {
    return Item('$name + ${item.name}', price + item.price);
  }
}

//定义购物车类
class ShoppingCart extends Meta with PrintHelper {
  DateTime date;
  String code;
  List<Item> bookings = [];

  @override
  double get price =>
      bookings.reduce((value, element) => value + element).price;

  @override
  String get name {
    return bookings.reduce((value, element) => value + element).name;
  }

  ShoppingCart(name, this.code, {required this.bookings})
      : date = DateTime.now(),
        super(name, 0.0);

  @override
  getInfo() => '''
  购物车信息:
  -----------------------------
      用户名: $name
      优惠码: $code
      总价: $price
      日期: $date
  -----------------------------
      ''';
}

void main() {
  ShoppingCart shoppingCart = ShoppingCart("张三", "123456",
      bookings: [Item('苹果', 10.0), Item('鸭梨', 20.0)])
    // 级联运算符:
    ..printInfo();
}

abstract class PrintHelper {
  printInfo() {
    print(getInfo());
  }

  getInfo();
}
