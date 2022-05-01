import '../../entity/brand_entity.dart';

class BrandsResponse {
  final List<Map<String, dynamic>> brands;

  BrandsResponse(this.brands);

  factory BrandsResponse.toJson(List<BrandEntity> entities) =>
      BrandsResponse(entities.map((e) => e.toJson()).toList());
}
