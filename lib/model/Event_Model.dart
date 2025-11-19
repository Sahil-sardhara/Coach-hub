class Event {
  final String title;
  final String time;
  final String description;

  final String? imageUrl; // nullable
  final String? imageAsset; // nullable

  final double price;
  final int slots;

  Event({
    required this.title,
    required this.time,
    required this.description,
    this.imageUrl,
    this.imageAsset,
    this.price = 0.0,
    this.slots = 0,
  });

  bool get isFree => price == 0.0;
  String get priceLabel => isFree ? "FREE" : "SAR ${price.toStringAsFixed(2)}";
}
