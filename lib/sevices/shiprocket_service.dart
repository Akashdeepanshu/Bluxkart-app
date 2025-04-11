import 'dart:convert';
import 'package:http/http.dart' as http;

class ShiprocketService {
  String? _authToken;

  // 🔹 Authenticate and get API token
  Future<String?> authenticate(String email, String password) async {
    final url = Uri.parse("https://apiv2.shiprocket.in/v1/external/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      _authToken = jsonDecode(response.body)["token"];
      return _authToken;
    }

    print("Authentication failed: ${response.body}");
    return null;
  }

  // 🔹 Create an order in Shiprocket
  Future<Map<String, dynamic>?> createOrder({
    required String token,
    required String orderId,
    required String name,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String zipcode,
    required double totalAmount,
    required List<dynamic> products,
  }) async {
    final url = Uri.parse("https://apiv2.shiprocket.in/v1/external/orders/create/adhoc");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "order_id": orderId,
        "order_date": DateTime.now().toIso8601String(),
        "pickup_location": "Primary",
        "billing_customer_name": name,
        "billing_address": address,
        "billing_city": city,
        "billing_state": state,
        "billing_pincode": zipcode,
        "billing_phone": phone,
        "order_items": products.map((product) {
          return {
            "name": product['title'] ?? "Unknown",
            "sku": product['id'] ?? "",
            "units": product['qty'] ?? 1,
            "selling_price": product['tprice'] ?? 0.0,
          };
        }).toList(),
        "payment_method": "Prepaid",
        "sub_total": totalAmount,
        "length": "10",
        "breadth": "10",
        "height": "10",
        "weight": "0.5"
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    print("Order creation failed: ${response.body}");
    return null;
  }

  // 🔹 Fetch estimated delivery time
  Future<String?> getEstimatedDelivery(
      String token, String pickupPincode, String deliveryPincode, double weight) async {
    final url = Uri.parse("https://apiv2.shiprocket.in/v1/external/courier/serviceability/");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "pickup_postcode": pickupPincode,
        "delivery_postcode": deliveryPincode,
        "cod": false,
        "weight": weight
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"]["etd"]; // ✅ Expected delivery time
    }

    print("Failed to fetch delivery time: ${response.body}");
    return null;
  }

  // 🔹 Fetch tracking details
  Future<String?> trackOrder(String token, String orderId) async {
    final url =
    Uri.parse("https://apiv2.shiprocket.in/v1/external/courier/track?order_id=$orderId");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["tracking_data"]["track_status"] ?? "No Updates"; // ✅ Return only status
    }

    print("Failed to track order: ${response.body}");
    return null;
  }
}
