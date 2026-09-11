void main () {
  double processOrder({
    required int orderId,
    required double itemPrice,
    String? promoCode,
    double? deliveryFee,
  }) {
    double price = itemPrice;
    if (promoCode == 'SAVE10') {
      price = price * 0.9;
    }
    double delivery = deliveryFee ?? 500.0;
    double total = price + delivery;
    print("\nHometask");
    print("Order ID: $orderId");
    print("Item price: $itemPrice"); 
    print("Delivery fee: $delivery"); 
    print("Final total: $total");
    return total;
  }
  processOrder( orderId: 101, itemPrice: 10000.0, promoCode: 'SAVE10', deliveryFee: 700);
}