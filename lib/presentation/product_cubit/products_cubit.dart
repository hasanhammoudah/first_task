import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/domain/entities/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/domain/failures/failures.dart';
import 'package:ecommerce/presentation/product_cubit/products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());

    final result = await repository.getProducts();

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
