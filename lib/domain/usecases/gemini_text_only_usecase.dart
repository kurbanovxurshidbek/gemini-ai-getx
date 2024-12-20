import 'package:dartz/dartz.dart';
import 'package:ngdemo28/domain/repositories/gemini_talk_repository.dart';

class GeminiTextOnlyUseCase {
  final GeminiTalkRepository repository;

  GeminiTextOnlyUseCase(this.repository);

  Future<Either<String, String>> call(String text) async {
    return await repository.onTextOnly(text);
  }
}