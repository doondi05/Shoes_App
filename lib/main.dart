import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<String> categories = ["All", "Sneakers", "Football", "Soccer"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Open drawer or menu here
          },
        ),
        title: Text(
          "Shoes",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              // Navigate to About page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            icon: Icon(Icons.info_outline, color: Colors.black),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          for (int i = 0; i < categories.length; i++)
            CategoryPage(category: categories[i]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          for (int i = 0; i < categories.length; i++)
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: categories[i],
            ),
        ],
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  // Updated map of category to image URLs
  static const Map<String, List<String>> categoryImages = {
    "All": [
      'assets/images/one.jpg',
      'assets/images/two.jpg',
      'assets/images/three.jpg',
    ],
    "Sneakers": [
      'https://image.made-in-china.com/2f0j00yvpisBodygzj/New-Fashion-Shoes-Men-Breathable-Trend-Men-Style-Brand-Wholesale-Couple-Running-Sports-Fashion-Trending-Sneaker.webp',
      'https://5.imimg.com/data5/ECOM/Default/2023/7/328823193/ET/CZ/MP/153114382/s9b621dff4c5447c0a9165642b9264c82e-9273da33-7579-4205-b9d4-33279aa91c31-500x500.jpg',
      'https://image.made-in-china.com/2f0j00cqWUFyStSjbK/Custom-Brand-Sports-Shoes-Men-2020-Stylish-Fashion-Sneaker-Mens-Running-Shoes-Man-Casual-Shoes-Breathable-Footwear-Manufacturer-Fal-T2028.webp',
    ],
    "Football": [
      'https://image.made-in-china.com/2f0j00DAQiJVpsnNga/New-High-Quality-Football-Shoes-Indoor-Soccer-Shoes-Training-Football-Shoes.jpg',
      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/ae3f966399585b860da7138dfe53c85d.jpg?imageMogr2/auto-orient%7CimageView2/2/w/800/q/70/format/webp',
      'https://thumblr.uniid.it/blog_component/106341/e1e40d41e6d6.jpg',
    ],
    "Soccer": [
      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d614426698ce39443935dfac8d8f5481.jpg?imageMogr2/auto-orient%7CimageView2/2/w/800/q/70/format/webp',
      'https://m.media-amazon.com/images/I/710tX98ybTL._AC_SY695_.jpg',
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/06300e5c31c1486d92b0694fa5cc5ec8_9366/predator-elite-firm-ground-soccer-cleats.jpg',
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<String> images = categoryImages[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          category,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return makeItem(
            image: images[index],
            tag: '$category$index',
            category: category,
            context: context,
          );
        },
      ),
    );
  }

  Widget makeItem({
    required String image,
    required String tag,
    required String category,
    required BuildContext context,
  }) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Shoes(
                image: image,
                tag: tag,
                category: category,
              ),
            ),
          );
        },
        child: Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: image.startsWith('http')
                  ? NetworkImage(image)
                  : AssetImage(image) as ImageProvider,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Nike",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "100\$",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Shoes extends StatefulWidget {
  final String image;
  final String tag;
  final String category;

  const Shoes({
    Key? key,
    required this.image,
    required this.tag,
    required this.category,
  }) : super(key: key);

  @override
  _ShoesState createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  bool addedToCart = false;

  void addToCart() {
    setState(() {
      addedToCart = true;
    });
    // Show a SnackBar to indicate item added to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added to cart!'),
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Hero(
          tag: widget.tag,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.image.startsWith('http')
                    ? NetworkImage(widget.image)
                    : AssetImage(widget.image) as ImageProvider,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 50,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.category,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Nike",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      addToCart();
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: addedToCart
                          ? Icon(Icons.done, color: Colors.black)
                          : Icon(Icons.shopping_cart, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 120, // Adjusted radius for larger size
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    'https://res.cloudinary.com/dy6kog5ja/image/upload/v1720008250/1000361824-removebg_sdptyr.png',
                  ),
                ),
              ),
              SizedBox(height: 40), // Adjusted height for spacing
              Text(
                "My name is K. Doondi. I am currently developing a website using Flutter to showcase a diverse range of shoes. With my proficiency in Java and Python, I bring a deep passion for coding, driven by a desire to address real-world challenges through innovative projects. I am committed to advancing technology and aspire to be recognized as a top coder, contributing impactful solutions that push the boundaries of innovation.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "My webpage features include:\n"
                    "- Showcase a diverse range of shoes\n"
                    "- Detailed information about each shoe category\n"
                    "- Shopping cart functionality\n"
                    "- User-friendly interface\n"
                    "- Integration with various shoe categories (All, Sneakers, Football, Soccer)\n",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
