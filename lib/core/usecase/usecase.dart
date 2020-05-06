abstract class UseCase<Type, Params> {
  Future<bool> call(Params params);
}