import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/services/api_service.dart';
import 'package:ecommerce/domain/entities/product_model.dart';
import 'package:ecommerce/domain/failures/failures.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final result = await apiService.fetchProducts();
      final products =
          result.map((data) => ProductModel.fromJson(data)).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
