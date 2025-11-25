import 'dart:convert';
import 'dart:developer';
import 'package:dfcp/constants/text_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dfcp/controllers/login_controller.dart';


class API {

  String baseUrl = "https://nmtdevserver.com/dfcp/api";

  LoginController loginController = Get.put(LoginController());

  verifyToken(String token) async {

    var url = "$baseUrl/auth/verify_token";

    Map<String, dynamic> body = {
      "token": token
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("accessToken verify :- ${response.body}");

    final result = jsonDecode(response.body);

    if(result["status"] == 1) {
      return true;
    } else {
      return false;
    }


  }

  registerAccount(String name, String mobile, String email, String password, userType, String referralCode ) async {

    var url = '$baseUrl/auth/userRegistration';

    Map<String, dynamic> body = {
      "name": name,
      "mobile": mobile,
      "email": email,
      "password": password,
      "user_type": userType,
      "referral_code": referralCode
    };

    log("register :- $url, $body");

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("register response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  verifyOtp(String email, String otp) async {

    var url = "$baseUrl/auth/verifyOTP";

    Map<String, dynamic> body = {
      "email": email,
      "otp": otp
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("verify otp response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  login(String email, String password) async {

    var url = "$baseUrl/auth/userLogin";

    Map<String, dynamic> body = {
      "email": email,
      "password": password
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("login response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  getProductsList() async {

    var url = "$baseUrl/product/all_product_list";

    http.Response response = await http.get(Uri.parse(url));
    log("productList response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  getProductDetail(String productId) async {

    var url = "$baseUrl/product/product_details";

    Map<String, dynamic> body = {
      "product_id": productId
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("product details response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  getCategories() async {

    var url = "$baseUrl/product/category_list";

    http.Response response = await http.get(Uri.parse(url));
    log("categories response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  addProduct(String categoryId, String productName, String availableQuantity, String quantity, String regularPrice,
    String sellingPrice, String shortDesc, String longDesc, String location,
    String image1, String? image2, String? image3, String? image4, String? image5, String lat, String long) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/product/add_product";

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields["token"] = loginController.accessToken!;
      request.fields["user_id"] = loginController.userId!;
      request.fields["cat_id"] = categoryId;
      request.fields["product_name"] = productName;
      request.fields["qty"] = availableQuantity;
      request.fields["weight"] = quantity;
      request.fields["regular_price"] = regularPrice;
      request.fields["selling_price"] = sellingPrice;
      request.fields["short_desc"] = shortDesc;
      request.fields["long_desc"] = longDesc;
      request.fields["location"] = location;
      request.fields["latitude"] = lat;
      request.fields["longitude"] = long;

      if (image1 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_1", image1));
      }
      if (image2 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_2", image2));
      }
      if (image3 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_3", image3));
      }
      if (image4 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_4", image4));
      }
      if (image5 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_5", image5));
      }

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      log("add product response in api :- $responseData");

      return responseData;
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  updateProduct(String categoryId, String productName, String availableQuantity, String quantity, String regularPrice,
    String sellingPrice, String shortDesc, String longDesc, String location,
    String image1, String? image2, String? image3, String? image4, String? image5,
    String productId, String lat, String long) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/product/update_product";

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields["token"] = loginController.accessToken!;
      request.fields["user_id"] = loginController.userId!;
      request.fields["product_id"] = productId;
      request.fields["cat_id"] = categoryId;
      request.fields["product_name"] = productName;
      request.fields["qty"] = availableQuantity;
      request.fields["weight"] = quantity;
      request.fields["regular_price"] = regularPrice;
      request.fields["selling_price"] = sellingPrice;
      request.fields["short_desc"] = shortDesc;
      request.fields["long_desc"] = longDesc;
      request.fields["location"] = location;
      request.fields["latitude"] = lat;
      request.fields["longitude"] = long;

      if (image1 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_1", image1));
      }
      if (image2 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_2", image2));
      }
      if (image3 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_3", image3));
      }
      if (image4 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_4", image4));
      }
      if (image5 != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image_5", image5));
      }

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      log("update product response in api :- $responseData");

      return responseData;
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  deleteProduct(String productId) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/product/delete_product";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "product_id": productId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("delete product response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getStates() async {

    var url = "$baseUrl/app/state_list";

    http.Response response = await http.get(Uri.parse(url));
    log("get states response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  getCities(String stateId) async {
    var url = "$baseUrl/app/city_list";

    Map<String, dynamic> body = {
      "state_id": stateId
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    log("get cities response in api :- ${response.body}");
    return jsonDecode(response.body);
  }

  addAddress(String name, String email, String phone, String address, String area,
    String cityId, String stateId, String zipcode, String addressType) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/user/add_address";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "area": area,
        "city_id": cityId,
        "state_id": stateId,
        "zipcode": zipcode,
        "address_type": addressType
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("add address response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  updateAddress(String name, String email, String phone, String address, String area,
      String cityId, String stateId, String zipcode, String addressType, String addressId) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/user/update_address";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "address_id": addressId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "area": area,
        "city_id": cityId,
        "state_id": stateId,
        "zipcode": zipcode,
        "address_type": addressType
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("update response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }

  }

  getAddress() async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/user/address_list";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("get address response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }

  }

  // getAddressDetail(String addressId) async {
  //
  //   bool isAccessToken = await verifyToken(loginController.accessToken!);
  //
  //   if(isAccessToken) {
  //     var url = "$baseUrl/user/address_details";
  //
  //     Map<String, dynamic> body = {
  //       "token": loginController.accessToken,
  //       "user_id": loginController.userId,
  //       "address_id": addressId
  //     };
  //
  //     http.Response response = await http.post(Uri.parse(url), body: body);
  //     log("address detail response in api :- ${response.body}");
  //     return jsonDecode(response.body);
  //   } else {
  //     return {"status": 0, "message": TextConstants.invalidToken};
  //   }
  // }

  deleteAddress(String addressId) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/user/delete_address";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "address_id": addressId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("delete address response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getMembersList(String userType) async {

    // bool isAccessToken = await verifyToken(loginController.accessToken!);
    //
    // if(isAccessToken) {

      var url = "$baseUrl/user/member_list";

      Map<String, dynamic> body = {
        // "token": loginController.accessToken,
        "user_type": userType
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("get memberList response in api :- ${response.body}");
      return jsonDecode(response.body);
    // } else {
    //   return {"status": 0, "message": TextConstants.invalidToken};
    // }
  }

  addToCart(String productId, String quantity) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/cart/add_to_cart";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId,
        "product_id" : productId,
        "qty" : quantity
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("add to cart response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getCartItems() async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/cart/cart_item_list";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("get cart item response is api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  updateCart(String cartId, String productId, String quantity) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/cart/update_cart";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId,
        "cart_id" : cartId,
        "product_id" : productId,
        "qty" : quantity
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("update cart response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  deleteCart(String cartId) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/cart/delete_cart";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId,
        "cart_id" : cartId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("delete cart response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }

  }

  buyNow(String productId, String qty, String addressId, String paymentMethod) async {
    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/orders/buy_now";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId,
        "product_id" : productId,
        "qty" : qty,
        "address_id" : addressId,
        "payment_method" : paymentMethod,
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("buy now response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  placeOrder(String addressId, String paymentMethod, List<Map<String, dynamic>> items) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/orders/place_order";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "address_id": addressId,
        "payment_method": paymentMethod,
        "cart_items": items
      };

      http.Response response = await http.post(Uri.parse(url), body: json.encode(body));
      log("place order response in api :- ${response.body}");
      return jsonDecode(response.body);

    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }
  
  createMeeting(String meetingUserId, String date, String time, String purpose, String description) async {
    
    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/meetings/create_meeting";

      Map<String, dynamic> body = {
        "token" : loginController.accessToken,
        "user_id" : loginController.userId,
        "meeting_person_id" : meetingUserId,
        "meeting_date" : date,
        "meeting_time" : time,
        "meeting_purpose" : purpose,
        "meeting_description" : description
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("create meeting response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  meetingList() async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/meetings/meeting_list";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("meeting list response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getOrderHistory() async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/orders/order_list";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("order list response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getOrderDetails(String orderId) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {
      var url = "$baseUrl/orders/order_details";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "order_id": orderId
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("order details response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  getProfile() async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/user/get_profile";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("profile response in api :- ${response.body}");
      return jsonDecode(response.body);
    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  updateProfile(String name, String mobileNo, String description, String? image) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/user/update_profile";

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields["token"] = loginController.accessToken!;
      request.fields["user_id"] = loginController.userId!;
      request.fields["name"] = name;
      request.fields["mobile"] = mobileNo;
      request.fields["decription"] = description;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath("profile_img", image));
      }

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      log("update profile response in api :- $responseData");

      return responseData;

    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }

  submitReview(String productId, int rating, String reviewMsg) async {

    bool isAccessToken = await verifyToken(loginController.accessToken!);

    if(isAccessToken) {

      var url = "$baseUrl/user/submit_review";

      Map<String, dynamic> body = {
        "token": loginController.accessToken,
        "user_id": loginController.userId,
        "product_id" : productId,
        "rating" : rating,
        "review_message" : reviewMsg
      };

      http.Response response = await http.post(Uri.parse(url), body: body);
      log("submit review response in api :- ${response.body}");
      return jsonDecode(response.body);

    } else {
      return {"status": 0, "message": TextConstants.invalidToken};
    }
  }


}