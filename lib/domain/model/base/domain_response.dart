abstract class DomainResponse<T> {
  final T data;
  final String message;

  DomainResponse(this.data, this.message);
}