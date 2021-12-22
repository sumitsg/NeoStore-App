// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/products/ProductRating/rating_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/add_to_cart_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_bloc.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_state.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String id;
  final String accessToken;
  final ProductDetailModel modelData;

  const ProductDetails({
    Key? key,
    required this.title,
    required this.accessToken,
    required this.id,
    required this.modelData,
  }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

Future<ProductRatingModel> setRating(String id, int rating) async {
  String rate = "3";
  if (rating < 3) {
    rate = "3";
  }
  const String url =
      "http://staging.php-dev.in:8844/trainingapp/api/products/setRating";
  var response = await http.post(Uri.parse(url), body: {
    'product_id': id,
    'rating': rate,
  });
  if (response.statusCode == 200) {
    var result = productRatingModelFromJson(response.body);
    print(result.userMsg);
    return result;
  } else {
    var errorres = productDetailModelFromJson(response.body);
    throw Exception(errorres.status);
  }
}

// ! add to cart api
Future<AddToCartModel> addToCart(int proId, int qty, String token) async {
  const String url = "http://staging.php-dev.in:8844/trainingapp/api/addToCart";

  var response = await http.post(Uri.parse(url),
      headers: {"access_token": token},
      body: {"product_id": '$proId', "quantity": '$qty'});
  if (response.statusCode == 200) {
    return addToCartModelFromJson(response.body);
  } else {
    var errorResponse = addToCartModelFromJson(response.body);
    throw Exception(errorResponse.userMsg);
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  final authRepository = AuthRepository();
  int position = 0;
  double rating = 0;
  String? img;
  late List<ProductImage> imageList;

  late ProductDetailModel proData;
  Data2? data;

  var itemQuantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      imageList = widget.modelData.data!.productImages;
      img = imageList[0].image;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: const [
          Icon(Icons.search),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13.33, vertical: 8.66),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => buyingQuantity(data!));
                },
                child: const Text(
                  'BUY NOW',
                  style: TextStyle(backgroundColor: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.PRIMARY_COLOR_GREY1),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopUpDialoag(context));
                },
                child: const Text(
                  'RATE',
                  style: TextStyle(color: AppColors.PRIMARY_COLOR_BLACK4),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: authRepository.getDetail(widget.id),
        builder: (context, AsyncSnapshot<ProductDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var item = snapshot.data;
            print('In future builder');
            proData = item!;
            data = proData.data;
            return Container(
              color: AppColors.PRIMARY_COLOR_GREY1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    tile(data!),
                    const SizedBox(
                      height: 17,
                    ),
                    imagesAndPrice(data!),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Padding imagesAndPrice(Data2 data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ! Price
                  Text(
                    'RS. ${data.cost}',
                    style: const TextStyle(
                        color: AppColors.PRIMARY_COLOR_RED5,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  // ! Share Button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    color: AppColors.PRIMARY_COLOR_GREY4,
                  ),
                ],
              ),
            ),
            // ! Center Image
            Image.network(
              // ignore: unrelated_type_equality_checks
              img == Null ? data.productImages[0].image : img!,
              height: 180,
              width: 260,
            ),
            const SizedBox(
              height: 6.5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 80,
                // width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: imageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    position = index;
                                    centerImage(imageList[index]);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: position == index
                                          ? Colors.red
                                          : Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Image.network(
                                    imageList[index].image,
                                    height: 70,
                                    width: 80,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: AppColors.PRIMARY_COLOR_GREY2,
            ),
            description(widget.modelData.data!),
            // const SizedBox(
            //   height: 90,
            // )
          ],
        ),
      ),
    );
  }

  centerImage(ProductImage src) {
    setState(() {
      img = src.image;
    });
  }

  Container description(Data2 data) {
    return Container(
      height: 190,
      child: ListTile(
        title: const Text(
          'Description',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR_BLACK3,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        // ? will add desc came from API
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            data.description,
            style: const TextStyle(
              color: AppColors.PRIMARY_COLOR_BLACK4,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

//! buy now Button pop up
  Widget buyingQuantity(Data2 data) {
    int? qty;
    return AlertDialog(
      title: Text(
        data.name,
        style: const TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 25,
            color: AppColors.PRIMARY_COLOR_BLACK2),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 33.33),
              // ! center image
              child: Container(
                width: 258,
                height: 178,
                child: Image.network(
                  img!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
            ),
            // ! text
            const Text(
              'Enter Qty',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: AppColors.PRIMARY_COLOR_BLACK2),
            ),
            const SizedBox(
              height: 22.0,
            ),
            // ! text field for quantity
            SizedBox(
              height: 43,
              width: 112,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: itemQuantity,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY_COLOR_BLACK2,
                        width: 1.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    // int _qty = int.parse(value!);
                    if (value!.isEmpty || int.parse(value) < 1) {
                      return 'Atleast 1 item required';
                    } else if (int.parse(value) > 8) {
                      return 'not more than 8 items allowed';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      qty = int.parse(value);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 22),
            // ! submit button
            ElevatedButton(
              onPressed: () async {
                // print(qty);
                if (_formKey.currentState!.validate()) {
                  await authRepository.addToCart(
                    widget.modelData.data!.productImages[0].productId,
                    qty!,
                    widget.accessToken,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Item added in cart...!! '),
                  ));
                  itemQuantity.clear();
                } else {
                  itemQuantity.clear();
                  Navigator.of(context, rootNavigator: true).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter Quantity between 1to 8...!! '),
                    ),
                  );
                }
              },
              child: const Text('SUBMIT',
                  style: TextStyle(
                    backgroundColor: AppColors.PRIMARY_COLOR_RED1,
                  )),
              style: ElevatedButton.styleFrom(fixedSize: const Size(192, 47)),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  // ! will do the Rating--------------------------------------------------->

  Widget _buildPopUpDialoag(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(widget.title),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            img!,
          ),
          Center(
            child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star,
                    color: AppColors.PRIMARY_COLOR_YELLOW,
                  );
                },
                onRatingUpdate: (rating) {
                  this.rating = rating;
                }),
            // ratingStar(),
          ),
          ElevatedButton(
            onPressed: () {
              authRepository.setRating(widget.id, rating.toInt());

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item Rated Successfully...!! '),
                ),
              );

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            title: widget.title,
                            id: widget.id,
                            accessToken: widget.accessToken,
                            modelData: widget.modelData,
                          )));
            },
            child: const Text(
              'RATE NOW',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR_WHITE,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

// !Rating--->
  Widget ratingStar() {
    int value = widget.modelData.data!.rating;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) {
            return Icon(
              index < value ? Icons.star : Icons.star_border,
              color: Colors.amber,
            );
          },
        ));
  }

// !first Tile of content
  Card tile(Data2? data2) {
    // final model = data;
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10),
          child: ListTile(
            title: Text(
              data2!.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.PRIMARY_COLOR_GREY6,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                category(data2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data2.producer,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: AppColors.PRIMARY_COLOR_BLACK3,
                      ),
                    ),
                    ratingStar(),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget category(Data2 data) {
    int? cid = data.productCategoryId;
    String? title1;
    switch (cid) {
      case 1:
        title1 = 'Tables';
        break;
      case 2:
        title1 = 'Chairs';
        break;
      case 3:
        title1 = 'Sofas';
        break;
      case 4:
        title1 = 'Cupboards';
        break;
    }
    return Text(
      'Category - $title1',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: AppColors.PRIMARY_COLOR_BLACK4,
      ),
    );
  }
}
