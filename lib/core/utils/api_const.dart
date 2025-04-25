class ApiConst {

 //indardeco-1903313897.eu-west-3.elb.amazonaws.com
  static const String ipAddress = "indardeco-1903313897.eu-west-3.elb.amazonaws.com";//ip Address
  static const String baseUrl = "http://$ipAddress/api"; 
  
  //authentication apis
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String getProfile = "$baseUrl/users/byId";
  static const String updateProfil = "$baseUrl/UpdateProfil";
  static const String updatePassword = "$baseUrl/updatepassword";
  static const String refreshToken = "$baseUrl/refreshtoken";
  static const String forgetPassword = "$baseUrl/forgetPassword";
  static const String verifyOTP = "$baseUrl/VerifCode";
  static const String resetPassword = "$baseUrl/Resetpassword";
  static const String updateUserImage = "$baseUrl/updateImage";
  static const String userEmail = "$baseUrl/users/email";
  static const String updateWishlist = "$baseUrl/updateWishlist";
  static const String updateCart = "$baseUrl/UpdateCart";

  //cart apis
  static const String addCart = "$baseUrl/cart/add";
  static const String getCart = "$baseUrl/cart/get";
  //static const String updateCart = "$baseUrl/cart/update";
  static const String deleteCart = "$baseUrl/cart/delete";

   //wishlist apis
  static const String addWishlist = "$baseUrl/wishlist/add";
  static const String getWishlist = "$baseUrl/wishlist/get";
 // static const String updateWishlist = "$baseUrl/wishlist/update";
  static const String deleteWishlist = "$baseUrl/wishlist/delete";

  //product apis
  static const String products = "$baseUrl/products";
  static const String sortdproducts = "$baseUrl/products/sorted";
  static const String category = "$baseUrl/products/category";

  //3Dproduct apis
  static const String product3D = "$baseUrl/3Dproducts";
  static const String allproduct3D = "$baseUrl/3Dproducts/all";

  //promotion apis
  static const String promotions = "$baseUrl/promotions";

  //category apis
  static const String categories = "$baseUrl/category";
  static const String subCategories = "$baseUrl/subcategory";

  //fournisseur apis 
  static const String supplier = "$baseUrl/supplier";

  //rating apis
  static const String ratings = "$baseUrl/ratings";
  static const String productRatings = "$baseUrl/products";

  //review apis
  static const String reviews = "$baseUrl/reviews";
  static const String uploadReviewImage = "$baseUrl/updateReviewimage";

  //sales apis
  static const String addSale = "$baseUrl/sales/create";
  static const String oneSale = "$baseUrl/sales/one";
  static const String allSales = "$baseUrl/sales";
 
 //reclamation apis
  static const String reclamations = "$baseUrl/reclamations";

  //service
  static const String serviceCategory="$baseUrl/service_category";
  static const String addService="$baseUrl/service/add";
  static const String service="$baseUrl/service";
  static const String allService="$baseUrl/service/all";
  static const String userService="$baseUrl/service/user";
  static const String addServiceImage="$baseUrl/addserviceimage";
  static const String updateServiceImage="$baseUrl/updateserviceimage";

  //notification
  static const String getOneNotification="$baseUrl/notifications/get";
  static const String getUerNotifications="$baseUrl/notifications/get/user";
  static const String updateNotifications="$baseUrl/notifications/update";
  static const String deleteNotifications="$baseUrl/notifications/delete";

/*
  //static const String paiement = "$baseUrl/payment";
*/
  //assets apis
  static const String userImages = "http://$ipAddress/api/uploads/images";
  static const String reviewImages = "http://$ipAddress/api/uploads/reviews";

}
