abstract class IDefaultException {
  final String? message;
  final StackTrace? stackTrace;
  final Object exception;

  IDefaultException(this.message, this.exception, [this.stackTrace]);

  @override
  String toString() {
    return message ??
        'Ocorreu um erro desconhecido, por favor tente novamente mais tarde!';
  }
}
