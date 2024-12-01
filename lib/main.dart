import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '211244'),
    );
  }
}

// Move clothingItems outside to make it constant
const List<Map<String, String>> clothingItems = [
  {
    'name': 'T-Shirt',
    'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
    'description': 'A comfortable cotton t-shirt.',
    'price': '15 USD',
  },
  {
    'name': 'Jeans',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7L3wEBrbho1U_hLpDwXtNhwlCZrEMn1l3-ZRcOxe_lMGbAdohl7IceCk&s',
    'description': 'Stylish slim-fit jeans.',
    'price': '40 USD',
  },
  {
    'name': 'Jacket',
    'image': 'https://images.unsplash.com/photo-1618329918461-51bb072e0ea5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Warm winter jacket.',
    'price': '60 USD',
  },
  {
    'name': 'Sneakers',
    'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Comfortable running sneakers.',
    'price': '50 USD',
  },
  {
    'name': 'T-Shirt',
    'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
    'description': 'A comfortable cotton t-shirt.',
    'price': '15 USD',
  },
  {
    'name': 'Jeans',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7L3wEBrbho1U_hLpDwXtNhwlCZrEMn1l3-ZRcOxe_lMGbAdohl7IceCk&s',
    'description': 'Stylish slim-fit jeans.',
    'price': '40 USD',
  },
  {
    'name': 'Jacket',
    'image': 'https://images.unsplash.com/photo-1618329918461-51bb072e0ea5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Warm winter jacket.',
    'price': '60 USD',
  },
  {
    'name': 'Sneakers',
    'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Comfortable running sneakers.',
    'price': '50 USD',
  },
  {
    'name': 'T-Shirt',
    'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
    'description': 'A comfortable cotton t-shirt.',
    'price': '15 USD',
  },
  {
    'name': 'Jeans',
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7L3wEBrbho1U_hLpDwXtNhwlCZrEMn1l3-ZRcOxe_lMGbAdohl7IceCk&s',
    'description': 'Stylish slim-fit jeans.',
    'price': '40 USD',
  },
  {
    'name': 'Jacket',
    'image': 'https://images.unsplash.com/photo-1618329918461-51bb072e0ea5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Warm winter jacket.',
    'price': '60 USD',
  },
  {
    'name': 'Sneakers',
    'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'description': 'Comfortable running sneakers.',
    'price': '50 USD',
  },
  
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: clothingItems.length,
        itemBuilder: (context, index) {
          final item = clothingItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: SizedBox(
                width: 60, // Fixed width
                height: 60, // Fixed height
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  child: Image.network(
                    item['image']!,
                    fit: BoxFit.cover, // Crop or scale image
                  ),
                ),
              ),
              title: Text(item['name']!),
              subtitle: Text(item['price']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      name: item['name']!,
                      image: item['image']!,
                      description: item['description']!,
                      price: item['price']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String price;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('211244'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Functional back button
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5.0, // Adds shadow to the card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        image,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.teal),
                    ),
                  ),
                  const Divider(height: 30, thickness: 1),
                  Text(
                    'Description:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Price:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    price,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}