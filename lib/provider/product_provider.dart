import 'package:flutter/widgets.dart';

class ProductProvider with ChangeNotifier{
  Map <String, dynamic> productDate = {};

  getFormData(
    {String ?productName, 
     double? productPrice, 
     int? quantity, 
     String? category, 
     String? description,
     DateTime ? scheduleDate, 
     List<String>? imageUrlList,
     bool? chargeShipping,
     int? shippingCharge,
     String? brandName,
     List<String>? codeList,
     }){
    if(productName!=null){
      productDate['productName']= productName;
    }

    if(productPrice!=null){
      productDate['productPrice'] = productPrice;
    }
    if(quantity!=null){
      productDate['quantity'] = quantity;
    }
    if(category!=null){
      productDate['category'] = category;
    }
    
    if(description != null){
      productDate['description'] = description;
    }
    if(scheduleDate != null){
      productDate['scheduleDate'] = scheduleDate;
    }
    if(imageUrlList != null){
      productDate['imageUrlList'] = imageUrlList;
    }
    if(chargeShipping != null){
      productDate['chargeShipping'] = chargeShipping;
    }
    if(shippingCharge != null){
      productDate['shippingCharge'] = shippingCharge;
    }
    if(brandName != null){
      productDate['brandName'] = brandName;
    }
    if(codeList != null){
      productDate['codeList'] = codeList;
    }

  }
}