class Products{
  final String item, quantity;
  const Products({required this.item, required this.quantity});

 Map toJson()=>{

      'product': item,
      'quantity': quantity,
    };


}