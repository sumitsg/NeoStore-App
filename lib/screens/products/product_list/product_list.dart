import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/products/productDetails/product_detail.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_event.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_bloc.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class ProductList extends StatefulWidget {
  final String title;
  ProductListModel products;
  final String access_token;
  ProductList(
      {Key? key,
      required this.title,
      required this.products,
      required this.access_token})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // late ProductListModel finalResult;
  final authRepo = AuthRepository();
  ProductListModel? prod;

  List<Data>? data;

  @override
  void initState() {
    data = widget.products.data.map((z) => z).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) =>
            ProductListBloc(authRepository: context.read<AuthRepository>()),
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (_, index) {
            final modelItem = data![index];

            return BlocConsumer<ProductListBloc, ProductState>(
              listener: (context, state) {},
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    // ! getting details page data from api
                    ProductDetailModel proData =
                        await (authRepo.getDetail(data![index].id.toString()));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RepositoryProvider(
                                  create: (context) => AuthRepository(),
                                  child: ProductDetails(
                                    title: data![index].name,
                                    accessToken: widget.access_token,
                                    id: data![index].id.toString(),
                                    modelData: proData,
                                  ),
                                )));
                  },
                  child: SizedBox(
                    height: 100,
                    // width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(13.33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // ! img--->
                          ProductImage(modelItem.productImages),

                          // ! name and info
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            child: SizedBox(
                              width: 290,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      // ! title-->
                                      ProductTitle(
                                        modelItem.name,
                                      ),
                                      const SizedBox(height: 4),
                                      // ! Producer-->
                                      ProductProducer(
                                        modelItem.producer,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // ! price -->
                                        Price(modelItem.cost),

                                        // ! ratings-->
                                        ratingStar1(data![index].rating),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

// !Rating--->
  Widget ratingStar1(int value) {
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

// ! Product Image-->
  Widget ProductImage(String url) {
    return SizedBox(
      height: 70,
      width: 80,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

// ! product Name----->
  Widget ProductTitle(String name) {
    return Text(
      name,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: AppColors.PRIMARY_COLOR_BLACK4),
    );
  }

// ! product producer----->
  Widget ProductProducer(String producer) {
    return Text(
      producer,
      style: const TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 12,
          color: AppColors.PRIMARY_COLOR_BLACK4),
    );
  }

// ! product price----->
  Widget Price(int price) {
    return Text(
      'Rs. ${price.toString()}',
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.PRIMARY_COLOR_RED5),
    );
  }
}

// ! product Ratings----->
class RatingStartWidget extends StatelessWidget {
  const RatingStartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star_outlined,
      color: AppColors.PRIMARY_COLOR_YELLOW,
      size: 20,
    );
  }
}

// ! product Ratings----->
class GreyRatingStartWidget extends StatelessWidget {
  const GreyRatingStartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star_outlined,
      color: AppColors.PRIMARY_COLOR_BLACK1,
      size: 20,
    );
  }
}
