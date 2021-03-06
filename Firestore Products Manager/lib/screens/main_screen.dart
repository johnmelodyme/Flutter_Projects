import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:firestore_products_manager/widgets/product_dialog.dart';
import 'package:firestore_products_manager/widgets/products_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Gerer Produit "),
      ),
      //Stream Builer
      body: StreamBuilder(
        stream: FireStoreDbService.products$,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return ProductsList(
              products: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // add icons
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ProductDialog(),
          );
        },
      ),
    );
  }
}
