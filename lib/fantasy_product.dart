class FantasyProduct{
  const FantasyProduct({
    this.price,
    this.name,
    this.description,
    this.image,
    this.weight,
  });
  final int price;
  final String name;
  final String description;
  final String image;
  final String weight;
}

const fantasyProduct = <FantasyProduct>[
  FantasyProduct(
    price: 50,
    name: 'ลาบหมู',
    description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
    image: 'assets/fantasy_store/1.png',
    weight: '500g'
  ),
  FantasyProduct(
      price: 40,
      name: 'ส้มตำ',
      description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
      image: 'assets/fantasy_store/2.png',
      weight: '500g'
  ),
  FantasyProduct(
      price: 50,
      name: 'ส้นตำไทย',
      description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
      image: 'assets/fantasy_store/3.png',
      weight: '500g'
  ),
  FantasyProduct(
      price: 80,
      name: 'ลาบหมูพิเศษ',
      description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
      image: 'assets/fantasy_store/4.png',
      weight: '500g'
  ),
  FantasyProduct(
      price: 30,
      name: 'ตำข้าวโพด',
      description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
      image: 'assets/fantasy_store/5.png',
      weight: '500g'
  ),
  FantasyProduct(
      price: 120,
      name: 'ลาบหมูโคตรพิเศษ',
      description: 'อร่อยเกิน อร่อยขนาดนี้ไม่เก็บไว้แดกคนเดียวละ มาขายเพื่อ',
      image: 'assets/fantasy_store/6.png',
      weight: '500g'
  ),
];