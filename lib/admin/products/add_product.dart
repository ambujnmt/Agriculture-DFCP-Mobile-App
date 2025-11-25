import 'dart:io';
import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/location_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:developer';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class AddProduct extends StatefulWidget {
  final String? productId, comingFrom;
  const AddProduct({super.key, this.productId, this.comingFrom});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  bool isLocationFetched = false;
  final customText = CustomText(), helper = Helper(), api = API();
  final ImagePicker _picker = ImagePicker();
  String? image1, image2, image3, image4, image5, selectedValue, selectedId;
  bool showSecondImgBox = false,
      showThirdImgBox = false,
      showFourthImgBox = false,
      showFifthImgBox = false,
      imageSelected = false,
      fetchingCategories = false,
      isApiCalling = false,
      deletingProduct = false,
      isImageDownloading = false;
  List categoriesList = [], productDetails = [], networkImage = [];
  List <String> categoriesNames = [];
  String lat = "", long = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController shortDesController = TextEditingController();
  TextEditingController longDesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController availableQuantityController = TextEditingController();

  LocationController locationController = Get.put(LocationController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    getCategories();
    if(widget.productId != null) {
      getProductDetails();
    }
  }

  getCategories() async {

    setState(() {
      fetchingCategories = true;
    });

    final response = await api.getCategories();

    setState(() {
      fetchingCategories = false;
    });

    if(response["status"] == 1) {
      categoriesList = response["result"];
      for(int i = 0; i < categoriesList.length; i++) {
        categoriesNames.add(categoriesList[i]["category_name"]);
      }
      setState(() {});
    }

    log("categories list in add product :- $categoriesList");
  }

  getProductDetails() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProductDetail(widget.productId!);

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {
      log("product details in data fetch time :- $response");
      setState(() {
        productDetails = response["result"];
      });
      manageProductData();
    }

  }

  manageProductData() {

    nameController.text = productDetails[0]["product_name"];
    shortDesController.text = productDetails[0]["short_desc"];
    longDesController.text = productDetails[0]["long_desc"];
    weightController.text = productDetails[0]["weight"];
    regularPriceController.text = productDetails[0]["regular_price"];
    sellingPriceController.text = productDetails[0]["selling_price"];
    addressController.text = productDetails[0]["location"];
    availableQuantityController.text = productDetails[0]["qty"];
    selectedValue = productDetails[0]["cat_name"];
    image1 = productDetails[0]["image_1"];
    showSecondImgBox = true;
    networkImage.add(image1);
    if(productDetails[0]["image_2"] != ""){
      image2 = productDetails[0]["image_2"];
      showThirdImgBox = true;
      networkImage.add(image2);
    }
    if(productDetails[0]["image_3"] != ""){
      image3 = productDetails[0]["image_3"];
      showFourthImgBox = true;
      networkImage.add(image3);
    }
    if(productDetails[0]["image_4"] != ""){
      image4 = productDetails[0]["image_4"];
      showFifthImgBox = true;
      networkImage.add(image4);
    }
    if(productDetails[0]["image_5"] != "") {
      image5 = productDetails[0]["image_5"];
      networkImage.add(image5);
    }

    setState(() {});
    downloadAllImage();
  }

  downloadAllImage() async {
    // log("downloadedImages list :- $networkImage, ${networkImage.length}");
    //
    // List temp = networkImage[0].toString().split("-");
    // log("temp List filename :- ${temp.last}");

    setState(() {
      isImageDownloading = true;
    });

    late var appDocDir;

    if (Platform.isAndroid) {
      appDocDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    }

    for (int i = 0; i < networkImage.length; i++) {
      List temp = networkImage[i].toString().split(".");
      String fileExtension = temp.last;

      String fileUrl = networkImage[i];
      String savePath = "${appDocDir!.path}/image$i.$fileExtension";

      log("save path :- $savePath");

      await Dio().download(fileUrl, savePath,
          onReceiveProgress: (count, total) {
            log("${(count / total * 100).toStringAsFixed(0)}%");
          });

      // downloadedImages.add("${appDocDir!.path}/$fileName");
      if (i == 0) {
        image1 = "${appDocDir!.path}/image$i.$fileExtension";
        log("image path 1 :- $image1");
      } else if (i == 1) {
        image2 = "${appDocDir!.path}/image$i.$fileExtension";
        log("image path 2 :- $image2");
      } else if (i == 2) {
        image3 = "${appDocDir!.path}/image$i.$fileExtension";
        log("image path 3 :- $image3");
      } else if (i == 3) {
        image4 = "${appDocDir!.path}/image$i.$fileExtension";
        log("image path 4 :- $image4");
      } else if (i == 4) {
        image5 = "${appDocDir!.path}/image$i.$fileExtension";
        log("image path 5 :- $image5");
      }
    }

    setState(() {
      isImageDownloading = false;
    });

  }

  fetchLocation() async {
    log("fetch location function called");

    if(locationController.permissionGranted == PermissionStatus.granted){
      LocationData locationValue = await locationController.getLocation();
      lat = locationValue.latitude!.toString();
      long = locationValue.longitude!.toString();
      List<geocode.Placemark> placemarks = await geocode.placemarkFromCoordinates(locationValue.latitude!, locationValue.longitude!);
      addressController.text = "${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
    } else {
      PermissionStatus permissionStatus = await locationController.locationPermission();
      if(permissionStatus == PermissionStatus.granted) {
        LocationData locationValue = await locationController.getLocation();
        lat = locationValue.latitude!.toString();
        long = locationValue.longitude!.toString();
        List<geocode.Placemark> placemarks = await geocode.placemarkFromCoordinates(locationValue.latitude!, locationValue.longitude!);
        addressController.text = "${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
      }
    }
  }

  showImageSelection(int from) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 20),
          height: 120,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  getImageFromGallery(from);
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Icon(
                        Icons.photo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    customText.kText("Gallery", 16, FontWeight.w400,
                        Colors.black, TextAlign.start),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  getImageFromCamera(from);
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Icon(
                        Icons.camera,
                      ),
                    ),
                    const SizedBox(height: 10),
                    customText.kText("Camera", 16, FontWeight.w400,
                        Colors.black, TextAlign.start),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Future getImageFromGallery(int from) async {
    XFile? image;

    if (from == 1) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        image1 = image!.path;
        imageSelected = true;
      }
    } else if (from == 2) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        image2 = image!.path;
      }
    } else if (from == 3) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        image3 = image!.path;
      }
    } else if (from == 4) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        image4 = image!.path;
      }
    } else if (from == 5) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        image5 = image!.path;
      }
    }

    print("images list :- $image1, $image2, $image3, $image4, $image5");
    setState(() {});
  }

  Future getImageFromCamera(int from) async {
    XFile? image;

    if (from == 1) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        image1 = image!.path;
        imageSelected = true;
      }
    } else if (from == 2) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        image2 = image!.path;
      }
    } else if (from == 3) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        image3 = image!.path;
      }
    } else if (from == 4) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        image4 = image!.path;
      }
    } else if (from == 5) {
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image?.path != null) {
        image5 = image!.path;
      }
    }

    print("images list :- $image1, $image2, $image3, $image4, $image5");
    setState(() {});
  }

  addUpdateProduct() async {

    for(int i = 0; i < categoriesList.length; i++) {
      if(selectedValue == categoriesList[i]["category_name"]) {
        selectedId = categoriesList[i]["id"];
        setState(() {});
      }
    }

    if(nameController.text.length >= 3 && helper.isAlphanumeric(nameController.text)) {
      if(shortDesController.text.isNotEmpty && helper.isAlphanumeric(shortDesController.text)) {
        if(longDesController.text.isNotEmpty && helper.isAlphanumeric(longDesController.text)) {
          if(selectedValue != null) {
            if(availableQuantityController.text.isNotEmpty && availableQuantityController.text != "0") {
              if(weightController.text.isNotEmpty && weightController.text != "0"){
                if(regularPriceController.text.isNotEmpty && regularPriceController.text != "0") {
                  if(sellingPriceController.text.isNotEmpty && sellingPriceController.text != "0") {
                    if(addressController.text.isNotEmpty && helper.isLocation(addressController.text)) {
                      if(image1 != null) {

                        setState(() {
                          isApiCalling = true;
                        });

                        final response;

                        if(widget.productId != null){
                          response = await api.updateProduct(selectedId!, nameController.text,
                              availableQuantityController.text,
                              weightController.text, regularPriceController.text,
                              sellingPriceController.text, shortDesController.text,
                              longDesController.text, addressController.text, image1!,
                              image2, image3, image4, image5, widget.productId!, lat, long);
                        } else {
                          response = await api.addProduct(selectedId!, nameController.text,
                            availableQuantityController.text,
                            weightController.text, regularPriceController.text,
                            sellingPriceController.text, shortDesController.text,
                            longDesController.text, addressController.text, image1!,
                            image2, image3, image4, image5, lat, long);
                        }

                        setState(() {
                          isApiCalling = false;
                        });

                        if(response["status"] == 1) {
                          helper.successDialog(response["message"]);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => const ProductsListing() ));
                        } else {
                          helper.errorDialog(response["message"]);
                          if(response["message"] == TextConstants.invalidToken) {
                            loginController.clearDataLogout();
                            helper.successDialog(TextConstants.logoutSuccess);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const ProductsViewScreen()),
                            );
                          }
                        }

                      } else {
                        helper.errorDialog(TextConstants.selectImg);
                      }
                    } else {
                      helper.errorDialog(TextConstants.enterLocation);
                    }
                  } else {
                    helper.errorDialog(TextConstants.validPrice);
                  }
                } else {
                  helper.errorDialog(TextConstants.validPrice);
                }
              } else {
                helper.errorDialog(TextConstants.validQuantity);
              }
            } else {
              helper.errorDialog(TextConstants.validAvailableQuantity);
            }
          } else {
            helper.errorDialog(TextConstants.selectCategory);
          }
        } else {
          helper.errorDialog(TextConstants.validLongDes);
        }
      } else {
        helper.errorDialog(TextConstants.validShortDes);
      }
    } else {
      helper.errorDialog(TextConstants.validProductName);
    }

  }

  deleteProduct() async {

    setState(() {
      deletingProduct = true;
    });

    final response = await api.deleteProduct(widget.productId!);

    setState(() {
      deletingProduct = false;
    });

    if(response["status"] == 1) {

      helper.successDialog(response["message"]);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductsListing() ));
    } else {
      helper.errorDialog(response["message"]);
      if(response["message"] == TextConstants.invalidToken) {
        loginController.clearDataLogout();
        helper.successDialog(TextConstants.logoutSuccess);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ProductsViewScreen()),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(

        appBar: AppBar(
          leading: GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: ColorConstants.kPrimary, shape: BoxShape.circle),
              child: Center(
                child: SizedBox(
                  height: 25,
                  child: Image.asset('assets/images/send_image1.png'),
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: customText.kAppTitle(),
        ),

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const CustomTitle(title: TextConstants.productUpload,),

                // customText.kText("Product Information", 20, FontWeight.w700, ColorConstants.kYellow, TextAlign.start),

                // name
                SizedBox(height: height * 0.01,),
                customText.kText(TextConstants.name, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: nameController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.name,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // short des
                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.shortDes, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: shortDesController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.shortDes,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // long des
                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.longDes, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    controller: longDesController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.longDes,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // categories
                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.categories, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      TextConstants.categories,
                      overflow: TextOverflow.ellipsis,
                      style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kTextGrey),
                    ),
                    items: categoriesNames
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: customText.kTextStyle(20, FontWeight.w400, Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: height * 0.06,
                      width: width * 0.95,
                      padding: const EdgeInsets.only(left:5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        border: Border.all(color: ColorConstants.kGrey),
                        // color: ColorConstants.kPrimary,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: width * 0.92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        // color: ColorConstants.kPrimary,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),

                // Total quantity
                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.availableQuantity, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    controller: availableQuantityController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.availableQuantity,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // weight
                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.per, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    controller: weightController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.per,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // regular price
                SizedBox(height: height * 0.02,),
                customText.kText("${TextConstants.regular} ${TextConstants.price} (Rs)", 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    controller: regularPriceController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.price,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                // sellingPrice
                SizedBox(height: height * 0.02,),
                customText.kText("${TextConstants.selling} ${TextConstants.price} (Rs)", 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    controller: sellingPriceController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TextConstants.price,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.location, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                SizedBox(
                  child: TextFormField(
                    controller: addressController,
                    // validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    cursorColor: ColorConstants.kPrimary,
                    style: customText.kTextStyle(18, FontWeight.w500,Colors.black),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if(isLocationFetched) {
                        addressController.text = value;
                        setState(() { });
                      }
                    },
                    onTap: () {
                      fetchLocation();
                    },
                    decoration: InputDecoration(
                      hintText: TextConstants.location,
                      hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.location_on_outlined, size: 40,),
                        onTap: () {
                          fetchLocation();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02,),
                customText.kText(TextConstants.image, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                isImageDownloading
                  ? Container(
                    height: height * .200,
                    width: width * .400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Colors.grey)
                    ),
                    child: const Center(
                      child: CustomProgressIndicator(),
                    ),
                  )
                  : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      image1 == null
                          ? GestureDetector(
                        child: Container(
                          height: height * .200,
                          width: width * .400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1, color: Colors.grey)
                          ),
                          child: const Center(
                            child: Icon(Icons.upload),
                          ),
                        ),
                        onTap: () {
                          showImageSelection(1);
                          showSecondImgBox = true;
                        },
                      )
                          : GestureDetector(
                        child: Container(
                            height: height * .200,
                            width: width * .400,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1, color: Colors.grey),
                              image: DecorationImage(
                                  image: image1!
                                      .contains("uploads/products")
                                      ? NetworkImage(image1!)
                                  as ImageProvider
                                      : FileImage(File(image1!)),
                                  fit: BoxFit.cover),
                            )),
                        onTap: () {
                          showImageSelection(1);
                        },
                      ),
                      image2 == null
                          ? Visibility(
                        visible: showSecondImgBox,
                        child: GestureDetector(
                          child: Container(
                            height: height * .200,
                            width: width * .400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey)),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                          onTap: () {
                            showImageSelection(2);
                            showThirdImgBox = true;
                          },
                        ),
                      )
                          : Visibility(
                        visible: showSecondImgBox,
                        child: GestureDetector(
                          child: Container(
                              height: height * .200,
                              width: width * .400,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey),
                                image: DecorationImage(
                                    image: image2!.contains(
                                        "uploads/business")
                                        ? NetworkImage(image2!)
                                    as ImageProvider
                                        : FileImage(File(image2!)),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () {
                            showImageSelection(2);
                          },
                        ),
                      ),
                      image3 == null
                          ? Visibility(
                        visible: showThirdImgBox,
                        child: GestureDetector(
                          child: Container(
                            height: height * .200,
                            width: width * .400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey)),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                          onTap: () {
                            showImageSelection(3);
                            showFourthImgBox = true;
                          },
                        ),
                      )
                          : Visibility(
                        visible: showThirdImgBox,
                        child: GestureDetector(
                          child: Container(
                              height: height * .200,
                              width: width * .400,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey),
                                image: DecorationImage(
                                    image: image3!.contains(
                                        "uploads/business")
                                        ? NetworkImage(image3!)
                                    as ImageProvider
                                        : FileImage(File(image3!)),
                                    // image: FileImage(File(image3!)),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () {
                            showImageSelection(3);
                          },
                        ),
                      ),
                      image4 == null
                          ? Visibility(
                        visible: showFourthImgBox,
                        child: GestureDetector(
                          child: Container(
                            height: height * .200,
                            width: width * .400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey)),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                          onTap: () {
                            showImageSelection(4);
                            showFifthImgBox = true;
                          },
                        ),
                      )
                          : Visibility(
                        visible: showFourthImgBox,
                        child: GestureDetector(
                          child: Container(
                              height: height * .200,
                              width: width * .400,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey),
                                image: DecorationImage(
                                  // image: FileImage(File(image4!)),
                                    image: image4!.contains(
                                        "uploads/business")
                                        ? NetworkImage(image4!)
                                    as ImageProvider
                                        : FileImage(File(image4!)),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () {
                            showImageSelection(4);
                          },
                        ),
                      ),
                      image5 == null
                          ? Visibility(
                        visible: showFifthImgBox,
                        child: GestureDetector(
                          child: Container(
                            height: height * .200,
                            width: width * .400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey)),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                          onTap: () {
                            showImageSelection(5);
                            showFifthImgBox = true;
                          },
                        ),
                      )
                          : Visibility(
                        visible: showFifthImgBox,
                        child: GestureDetector(
                          child: Container(
                              height: height * .200,
                              width: width * .400,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: Colors.grey),
                                image: DecorationImage(
                                  // image: FileImage(File(image5!)),
                                    image: image5!.contains(
                                        "uploads/business")
                                        ? NetworkImage(image5!)
                                    as ImageProvider
                                        : FileImage(File(image5!)),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () {
                            showImageSelection(5);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.05,),

                Row(
                  mainAxisAlignment: widget.productId != null? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                  children: [

                    if(widget.productId != null)
                    GestureDetector(
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorConstants.kGrey),
                          borderRadius: BorderRadius.circular(width * 0.02),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0,4),
                                  blurRadius: 9.9,
                                  color: Colors.black54
                              )
                            ]
                        ),
                        child: deletingProduct
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: CustomProgressIndicator(),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: ColorConstants.kGrey,),
                              customText.kText(TextConstants.delete, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
                            ],
                          ),
                      ),
                      onTap: () {

                        helper.alertDialog(context,
                          TextConstants.delete,
                          TextConstants.deleteAlertConfirmation,
                          () {
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          },
                          () {
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            deleteProduct();
                          },
                        );
                        
                      },
                    ),

                    SizedBox(
                      height: height * 0.05,
                      width: width * 0.3,
                      child: CustomButton(
                        buttonText: widget.productId != null ? TextConstants.update : TextConstants.add,
                        loader: isApiCalling,
                        onpress: () {
                          addUpdateProduct();
                        },
                      ),
                    )

                  ],
                ),

                SizedBox(height: height * 0.03,),

              ],
            ),
          ),
        )
      ),
    );
  }
}
