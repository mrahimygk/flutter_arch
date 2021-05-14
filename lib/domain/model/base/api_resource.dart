import 'status.dart';

class ApiResource<T> {
  final T data;
  final Status status;

  ApiResource(
    this.data,
    this.status,
  );
}
