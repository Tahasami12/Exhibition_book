enum ViewStatus { idle, loading, success, failure }

/// Lightweight view state holder to keep Cubit states consistent.
class ViewState<T> {
  final ViewStatus status;
  final T? data;
  final String? message;

  const ViewState({
    this.status = ViewStatus.idle,
    this.data,
    this.message,
  });

  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success;
  bool get hasError => status == ViewStatus.failure;

  ViewState<T> copyWith({
    ViewStatus? status,
    T? data,
    String? message,
  }) {
    return ViewState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
