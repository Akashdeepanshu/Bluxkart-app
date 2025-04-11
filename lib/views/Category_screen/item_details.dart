import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import 'package:bluxkart/constants/lists.dart';
import 'package:bluxkart/constants/strings.dart';
import 'package:bluxkart/controllers/product_controller.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';

import '../Cart_screen/cart_screen.dart';
import '../home_screen/productsbysubcat.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, this.data});

  Color parseColor(String colorString) {
    try {
      return Color(int.parse("0x$colorString"));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    int price = int.parse(data['p_price']);
    int discount = int.parse(data['p_discount'] ?? '0');
    int finalPrice = price - ((price * discount) ~/ 100);

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: title!.text.white.make(),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
          ),
          actions: [
            Obx(() => IconButton(
              icon: Icon(
                controller.isfav.value ? Icons.favorite : Icons.favorite_border,
                color: controller.isfav.value ? Colors.red : Colors.white,
              ),
              onPressed: () {
                controller.isfav.value
                    ? controller.removeFromWishlist(data.id, context)
                    : controller.addToWishlist(data.id, context);
              },
            )),
            IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}),
          ],
        ),
        bottomNavigationBar: ourButton(
          title: "Add to Cart",
          color: Colors.black,
          texTcolor: Colors.white,
          onPress: () {
            if (controller.quantity.value <= 0) {
              VxToast.show(context, msg: "Quantity should be greater than 0");
              return;
            }

            if (controller.selectedSize.value.isEmpty) {
              VxToast.show(context, msg: "Please select a size");
              return;
            }

            controller.addToCart(
              vendorID: data['vendor_id'],
              title: data['p_name'],
              img: data['p_images'][0],
              color: data['p_colors'][controller.colorindex.value],
              qty: controller.quantity.value,
              tprice: controller.totalPrice.value,
              size: controller.selectedSize.value,
            );

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 120, child: Lottie.asset("assets/lottie/AddedtoCart.json", repeat: false)),
                    10.heightBox,
                    const Text("Item Added to Cart!", style: TextStyle(fontWeight: FontWeight.bold)),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Continue")),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Get.to(() => const CartScreen());
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                          child: const Text("Go to Cart"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ).box.height(60).make(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Swiper
              VxSwiper.builder(
                itemCount: data['p_images'].length,
                autoPlay: true,
                height: 300,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(data['p_images'][index], fit: BoxFit.cover),
                ),
              ),
              20.heightBox,

              // Product Title and Rating
              title!.text.size(20).white.bold.make(),
              10.heightBox,
              VxRating(
                value: double.parse(data['p_rating']),
                onRatingUpdate: (value){},
                normalColor: Colors.grey,selectionColor:Vx.red50 ,
                count: 5,size: 25,stepInt: false,maxRating: 5,isSelectable: false,),
              10.heightBox,

              // Price Section
              Row(
                children: [
                  "\₹$finalPrice".text.size(22).white.bold.make(),
                  if (discount > 0) ...[
                    10.widthBox,
                    "\₹$price"
                        .text
                        .white
                        .lineThrough
                        .size(16)
                        .make(),
                    6.widthBox,
                    "($discount% OFF)".text.green500.size(16).make(),
                  ]
                ],
              ),
              20.heightBox,

              // Color Options
              "Color".text.white.bold.make(),
              10.heightBox,
              Obx(() => Row(
                children: List.generate(data['p_colors'].length, (index) {
                  final color = parseColor(data['p_colors'][index]);
                  final isSelected = controller.colorindex.value == index;

                  return GestureDetector(
                    onTap: () {
                      controller.colorindex.value = index;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 20,
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                    ),
                  );
                }),
              )),


              20.heightBox,

              // Size Options
              "Size".text.white.bold.make(),
              10.heightBox,
              Obx(() => Wrap(
                spacing: 10,
                children: List.generate(data['p_size'].length, (index) {
                  final size = data['p_size'][index];
                  final isSelected = controller.selectedSize.value == size;

                  return ChoiceChip(
                    label: Text(
                      size,
                      style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.white,
                    backgroundColor: Colors.grey.shade800,
                    onSelected: (_) => controller.selectedSize.value = size,
                  );
                }),
              )),

              20.heightBox,

              // Quantity Selector
              "Quantity".text.white.bold.make(),
              10.heightBox,
              Obx(() => Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      controller.decreaseQuantity();
                      controller.calculateTotalPrice(finalPrice);
                    },
                  ),
                  "${controller.quantity.value}".text.white.size(18).make(),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      controller.increaseQuantity(data["p_quantity"]);
                      controller.calculateTotalPrice(finalPrice);
                    },
                  ),
                  10.widthBox,
                  "Available: ${data["p_quantity"]}".text.white.make(),
                ],
              )),
              20.heightBox,

              // Total Price
              Obx(() => "Total: \₹${controller.totalPrice.value}".text.white.bold.size(18).make()),
              20.heightBox,

              // Description
              "Description".text.white.bold.make(),
              10.heightBox,
              "${data['p_desc']}".text.white.make(),
              20.heightBox,

              // Extra Info List
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  itemDetailsList.length,
                      (index) => ListTile(
                    title: itemDetailsList[index].text.white.make(),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ),
                ),
              ),
              30.heightBox,

              // You May Also Like
              productmaylike.text.white.bold.size(16).make(),
              homeproducts(title: "newdrops")
            ],
          ),
        ),
      ),
    );
  }
}
