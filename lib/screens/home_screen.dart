// import 'package:flutter/material.dart';
// import 'package:matget/screens/product_detail_page.dart';
// import 'package:matget/screens/shop_details_page.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 5),

//               // TOP LOCATION + NOTIFICATION + PROFILE
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         color: Color(0xffff7d3b),
//                         size: 23,
//                       ),
//                       SizedBox(width: 4),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Deliver to",
//                             style: TextStyle(color: const Color.fromARGB(255, 108, 108, 108), fontSize: 12),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "123, Bijnor (UP), India",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Icon(Icons.keyboard_arrow_down, size: 18),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.notifications, size: 24),
//                       // SizedBox(width: 12),
//                       // Container(
//                       //   padding: EdgeInsets.all(2), // Border width
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.black, // Border color
//                       //     shape: BoxShape.circle,
//                       //   ),
//                       //   child: CircleAvatar(
//                       //     radius: 14,
//                       //     backgroundImage: AssetImage(
//                       //       "assets/images/profile.png",
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ],
//               ),

//                SizedBox(height: 20),

//               // // SEARCH TITLE
//               // Text(
//               //   "What material are you looking for?",
//               //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
//               // ),

//               // SizedBox(height: 14),

//               // SEARCH BAR
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 4,
//                       spreadRadius: 0,
//                       offset: Offset(0, 1),
//                     ),
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                   border: BoxBorder.all(color: Colors.grey[400]!, width: 1),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search for materials...",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: InputBorder.none,
//                     icon: Icon(Icons.search, color: Colors.grey, size: 26,),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),

//               // CATEGORIES TITLE
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Categories",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     "See all",
//                     style: TextStyle(
//                       color: Color(0xffff7d3b),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 12),

//               // CATEGORIES ROW
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildCategory("Bricks", "assets/images/Bricks1.png"),
//                   _buildCategory("Sand", "assets/images/sand1.png"),
//                   _buildCategory("Cement", "assets/images/Cement1.png"),
//                   _buildCategory("TMT Bar", "assets/images/Steel1.png"),
//                   _buildCategory("Gravel", "assets/images/gravel1.png"),
//                 ],
//               ),

//               SizedBox(height: 26),

//               // POPULAR MATERIALS
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Popular Materials",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     "See all",
//                     style: TextStyle(
//                       color: Color(0xffff7d3b),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 12),

//               // POPULAR MATERIAL CARDS
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ProductDetailsPage(),
//                           ),
//                         );
//                       },
//                       splashColor: Colors.black12,
//                       highlightColor: Colors.black12,
//                       hoverColor: Colors.black12,
//                       borderRadius: BorderRadius.circular(12),
//                       child: _buildMaterialCard(
//                         "River Sand",
//                         "Fine Grade",
//                         "25 Rs/Kg",
//                         "assets/images/sand.jpeg",
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ProductDetailsPage(),
//                           ),
//                         );
//                       },
//                       splashColor: Colors.black12,
//                       highlightColor: Colors.black12,
//                       hoverColor: Colors.black12,
//                       borderRadius: BorderRadius.circular(12),
//                       child: _buildMaterialCard(
//                         "Red Bricks",
//                         "Clay, Fired",
//                         "5 Rs/pc",
//                         "assets/images/bricks.jpeg",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 26),

//               // NEARBY SHOPS
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Nearby Shops",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     "See all",
//                     style: TextStyle(
//                       color: Color(0xffff7d3b),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 12),

//               InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ShopDetailsPage(),
//                           ),
//                         );
//                       },
//                       splashColor: Colors.black12,
//                       highlightColor: Colors.black12,
//                       hoverColor: Colors.black12,
//                       borderRadius: BorderRadius.circular(12),
//                       child: _buildShopCard(),
//                     ),

//               SizedBox(height: 12),
//               _buildShopCard(),
//               SizedBox(height: 12),
//               _buildShopCard(),
//               SizedBox(height: 12),
//               _buildShopCard(),
//               SizedBox(height: 12),
//               _buildShopCard(),

//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // CATEGORY WIDGET
//   Widget _buildCategory(String name, String image) {
//     return Column(
//       children: [
//         Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14), // corner radius
//             border: BoxBorder.all(color: Colors.grey[400]!, width: 0.2),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 2,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.asset(image, fit: BoxFit.cover),
//           ),
//         ),

//         SizedBox(height: 6),

//         Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//       ],
//     );
//   }

//   // MATERIAL CARD WIDGET
//   Widget _buildMaterialCard(
//     String title,
//     String subtitle,
//     String price,
//     String img,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: BoxBorder.all(color: Colors.grey[400]!, width: 0.3),
//         boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 8),
//               ),
//             ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
//             child: Image.asset(
//               img,
//               height: 110,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 2),
//                 Text(subtitle, style: TextStyle(color: Colors.grey[600])),
//                 SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       price,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Color(0xffff7d3b),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.add, color: Colors.white, size: 18),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // SHOP CARD
//   Widget _buildShopCard() {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: BoxBorder.all(color: Colors.grey[400]!, width: 0.3),
//         boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 8),
//               ),
//             ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               "assets/images/shop.png",
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(width: 14),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Bharat Hardware Store",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 "Chandpur, India",
//                 style: TextStyle(color: Colors.grey[600]),
//               ),
//               SizedBox(height: 6),
//               Row(
//                 children: [
//                   Icon(Icons.star, size: 16, color: Colors.orange),
//                   SizedBox(width: 4),
//                   Text("4.8"),
//                   SizedBox(width: 12),
//                   Icon(Icons.location_on, size: 16, color: Colors.redAccent),
//                   Text("1.2 km"),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:matget/screens/product_detail_page.dart';
import 'package:matget/screens/shop_details_page.dart';

// ─── Theme Colors (matches Order, Cart, Profile pages) ────────────────────────
const _primary = Color(0xFFE8541A);
const _primaryLight = Color(0xFFFFF0EB);
const _textDark = Color(0xFF1A1A2E);
const _textGrey = Color(0xFF6B7280);
const _textLight = Color(0xFF9CA3AF);
const _divider = Color(0xFFE5E7EB);
const _starYellow = Color(0xFFFBBF24);
//const _scaffoldBg   = Color(0xFFF5F5F5);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ── AppBar: Address + Search ───────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        toolbarHeight: 110,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Address Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: _primary,
                          size: 23,
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Deliver to",
                              style: TextStyle(color: _textGrey, fontSize: 12),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "123,Chandpur, Bijnor(UP), India",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _textDark,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18,
                                  color: _textDark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: _primary,
                            size: 22,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: _primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ── Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 242, 241, 241),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _divider, width: 1),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 4,
                    //     spreadRadius: 0,
                    //     offset: Offset(0, 1),
                    //   ),
                    // ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search for materials...",
                      hintStyle: TextStyle(color: _textLight, fontSize: 14),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: _textLight, size: 26),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(1),
        //   child: Container(height: 1, color: _divider),
        // ),
      ),

      // ── Body ──────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ── CATEGORIES
            _sectionHeader("Categories", onSeeAll: () {}),
            const SizedBox(height: 12),

            // Horizontal scroll
            SizedBox(
              height: 88,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildCategory("Bricks", "assets/images/Bricks1.png"),
            ),
                  const SizedBox(width: 14),
                  InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildCategory("Sand", "assets/images/sand1.png"),
            ),
                  
                  const SizedBox(width: 14),
                InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildCategory("Cement", "assets/images/Cement1.png"),
            ),
                  
                  const SizedBox(width: 14),
                  InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildCategory("TMT Bar", "assets/images/Steel1.png"),
            ),
                  
                  const SizedBox(width: 14),
                  InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildCategory("Gravel", "assets/images/gravel1.png")
            ),
                  
                  const SizedBox(width: 14),
                  _buildCategory("Paint", "assets/images/gravel1.png"),
                  const SizedBox(width: 14),
                  _buildCategory("Pipes", "assets/images/gravel1.png"),
                  const SizedBox(width: 14),
                  _buildCategory("Tools", "assets/images/gravel1.png"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── POPULAR MATERIALS
            _sectionHeader("Popular Materials", onSeeAll: () {}),
            const SizedBox(height: 12),

            // Horizontal scroll
            SizedBox(
              height: 210,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 157,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProductDetailsPage()),
                      ),
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
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 157,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProductDetailsPage()),
                      ),
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
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 157,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProductDetailsPage()),
                      ),
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      hoverColor: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMaterialCard(
                        "Portland Cement",
                        "50kg Bag",
                        "380 Rs/bag",
                        "assets/images/sand.jpeg",
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 157,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProductDetailsPage()),
                      ),
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      hoverColor: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMaterialCard(
                        "TMT Steel Bar",
                        "12mm, Fe500",
                        "65 Rs/kg",
                        "assets/images/bricks.jpeg",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── NEARBY SHOPS
            _sectionHeader("Nearby Shops", onSeeAll: () {}),
            const SizedBox(height: 12),

            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShopDetailsPage()),
              ),
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              child: _buildShopCard(),
            ),
            const SizedBox(height: 12),
            _buildShopCard(),
            const SizedBox(height: 12),
            _buildShopCard(),
            const SizedBox(height: 12),
            _buildShopCard(),
            const SizedBox(height: 12),
            _buildShopCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Section Header ─────────────────────────────────────────────────────────
  Widget _sectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _textDark,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            "See all",
            style: TextStyle(
              color: _primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ── Category Widget ────────────────────────────────────────────────────────
  Widget _buildCategory(String name, String image) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: _primaryLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _divider, width: 0.8),
            // boxShadow: const [
            //   BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
      ],
    );
  }

  // ── Material Card Widget ───────────────────────────────────────────────────
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
        border: Border.all(color: _divider, width: 0.8),
        // boxShadow: const [
        //   BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: _textGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: _primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
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

  // ── Shop Card ──────────────────────────────────────────────────────────────
  Widget _buildShopCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _divider, width: 0.8),
        // boxShadow: const [
        //   BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        // ],
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bharat Hardware Store",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Chandpur, India",
                  style: TextStyle(fontSize: 13, color: _textGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.star, size: 15, color: _starYellow),
                    SizedBox(width: 4),
                    Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.location_on, size: 14, color: _primary),
                    SizedBox(width: 2),
                    Text(
                      "1.2 km",
                      style: TextStyle(fontSize: 12, color: _textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const Icon(Icons.chevron_right, color: _textLight, size: 20),
        ],
      ),
    );
  }
}
