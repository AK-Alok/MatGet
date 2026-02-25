import 'package:flutter/material.dart';
import 'package:matget/screens/productdetailpage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),

              // TOP LOCATION + NOTIFICATION + PROFILE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 23,
                      ),
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deliver to",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text(
                                "123, Bijnor, India",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications, size: 24),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.all(2), // Border width
                        decoration: BoxDecoration(
                          color: Colors.black, // Border color
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            "assets/images/profile.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              // SEARCH TITLE
              Text(
                "What material are you looking for?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),

              SizedBox(height: 14),

              // SEARCH BAR
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: BoxBorder.all(color: Colors.grey[400]!, width: 1),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for materials...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // CATEGORIES TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // CATEGORIES ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategory("Sand", "assets/images/sand.jpeg"),
                  _buildCategory("Gravel", "assets/images/gravel.jpg"),
                  _buildCategory("Bricks", "assets/images/bricks.jpeg"),
                  _buildCategory("Wood", "assets/images/wood.jpg"),
                  _buildCategory("Sand", "assets/images/sand.jpeg"),
                ],
              ),

              SizedBox(height: 26),

              // POPULAR MATERIALS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Materials",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // POPULAR MATERIAL CARDS
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsPage(),
                          ),
                        );
                      },
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      hoverColor: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMaterialCard(
                        "River Sand",
                        "Fine Grade",
                        "25 Rs/Kg",
                        "assets/images/sand.jpeg",
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsPage(),
                          ),
                        );
                      },
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      hoverColor: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMaterialCard(
                        "Red Bricks",
                        "Clay, Fired",
                        "5 Rs/pc",
                        "assets/images/bricks.jpeg",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26),

              // NEARBY SHOPS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby Shops",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              _buildShopCard(),
              SizedBox(height: 12),
              _buildShopCard(),
              SizedBox(height: 12),
              _buildShopCard(),
              SizedBox(height: 12),
              _buildShopCard(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.fire_truck), label: "Track"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }

  // CATEGORY WIDGET
  Widget _buildCategory(String name, String image) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14), // corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),

        SizedBox(height: 6),

        Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // MATERIAL CARD WIDGET
  Widget _buildMaterialCard(
    String title,
    String subtitle,
    String price,
    String img,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              img,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SHOP CARD
  Widget _buildShopCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/shop.png",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bharat Hardware Store",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                "Chandpur, India",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  SizedBox(width: 4),
                  Text("4.8"),
                  SizedBox(width: 12),
                  Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                  Text("1.2 km"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
