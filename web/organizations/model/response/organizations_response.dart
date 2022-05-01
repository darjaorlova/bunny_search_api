import '../../entity/organization_entity.dart';

class OrganizationsResponse {
  final List<Map<String, dynamic>> organizations;

  OrganizationsResponse(this.organizations);

  factory OrganizationsResponse.toJson(List<OrganisationEntity> entities) =>
      OrganizationsResponse(entities.map((e) => e.toJson()).toList());
}
