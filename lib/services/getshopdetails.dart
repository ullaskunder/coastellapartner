class ShopDetails
{
  String shopId,shopImage,shopLogo,name,
      phone,password,address,lat,long,rating,
      previousOrders,isDelivery,language,isCarryBag,
      isCartonBox,type;

  ShopDetails(this.shopId,this.shopImage,this.shopLogo,this.name,
      this.phone,this.password,this.address,this.lat,this.long,this.rating,
      this.previousOrders,this.isDelivery,this.language,this.isCarryBag,
      this.isCartonBox,this.type);

  ShopDetails.fromJson(Map<String,dynamic> json)
  {
    shopId = json['sid'];
    shopImage = json['sImage'];
    shopLogo = json['sLogo'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    rating = json['rating'];
    previousOrders = json['previousOrders'];
    isDelivery = json['isDelivery'];
    language = json['language'];
    isCarryBag = json['isCarryBag'];
    isCartonBox = json['isCartonBox'];
    type = json['type'];
  }

}