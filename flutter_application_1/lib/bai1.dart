import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sanpham/product.dart';
import 'package:http/http.dart' as http;

class Cau1 extends StatefulWidget {
  const Cau1({Key? key}) : super(key: key);

  @override
  State<Cau1> createState() => _HomeState();
}

class _HomeState extends State<Cau1> {
  late Future<List<Product>> _product;

  void initState() {
    super.initState();
    _product = _fetchProduct();
  }

  Future<List<Product>> _fetchProduct() async {
    final res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (res.statusCode == 200) {
      final List<dynamic> productList = jsonDecode(res.body);
      return productList
          .map<Product>((json) => Product.fromJson(json))
          .toList();
    } else {
      throw Exception("Error loading data");
    }
  }

  ThemeMode _themeMode = ThemeMode.light;
  int _currentIndex = 0;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const TextField(
            style: TextStyle(), // Màu chữ của thanh tìm kiếm
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(Icons.search, color: Colors.black),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.dashboard, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.article, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.card_travel, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_box, color: Colors.white)),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
// ignore: prefer_const_literals_to_create_immutables
            children: [
              const DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          AssetImage('assets/images/rectangle.png'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Askfak Sayem'),
                        Text('askfaksayem@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Sneakers',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 10), // Tạo khoảng cách giữa văn bản và icon
                      Icon(Icons.account_balance_wallet_rounded),
                      SizedBox(width: 10), // Tạo khoảng cách giữa hai icon
                      Icon(Icons.add_location_alt_outlined),
                    ],
                  ),
                ),
                FutureBuilder<List<Product>>(
                  future: _product,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${snapshot.data!.length} San pham duoc tim thay',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.map((product) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200, // Độ cao của Card
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2, // Tối đa 2 dòng
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ), // Khoảng cách giữa tiêu đề và giá
                                          Text(
                                            '${product.price}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
