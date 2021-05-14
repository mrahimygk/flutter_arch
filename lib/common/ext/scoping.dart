/// These are base extensions on all Types to simulate kotlin scope functions
/*
extension ObjectUtils<T, R> on Object {
  R let<T>(Function(T) transform) => transform.call(this);
  T takeIf<T>(bool Function(T) validator) => validator(this) ? this : null;
  T also<T>(Function(T) run) {
    run(this);
    return this;
  }

  T cast<T>() => this is T ? this : null;

  String valueOf() => this.toString().split(".").last;
}
*/
