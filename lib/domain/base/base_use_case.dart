import 'package:flutter_architecture/lib/domain/model/base/api_resource.dart';
abstract class BaseUseCase<REQ, RES> {
  Stream<ApiResource<RES>> execute(REQ request);
}