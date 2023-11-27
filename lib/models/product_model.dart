class Products{
  final String item, quantity, preptime;
  final DateTime date;
  const Products(this.preptime, this.date, {required this.item, required this.quantity});

 Map toJson()=>{
      'date':date,
      'prepTime':preptime,
      'product': item,
      'quantity': quantity,
    };


}