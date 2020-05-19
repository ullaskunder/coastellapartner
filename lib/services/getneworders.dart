class NewOrders
{
  var oid,userPickupTime,orderList,orderType,userComment,isCarryBag,isCartonBox,name,phone,address;

  NewOrders(this.oid,this.userPickupTime,this.orderList,
      this.orderType,this.userComment,this.isCarryBag,this.isCartonBox,
      this.name,this.phone,this.address);

  NewOrders.fromJson(Map<String,dynamic> json)
  {
    oid=NewOrders.fromJson(json['oid']);
    /*userPickupTime=json['userPickupTime'];
    orderList=json['orderList'];
    orderType=json['orderType'];
    userComment=json['userComment'];
    isCarryBag=json['isCarryBag'];
    isCartonBox=json['isCartonBox'];
    name=json['name'];
    phone=json['phone'];
    address=json['address'];*/
  }
}