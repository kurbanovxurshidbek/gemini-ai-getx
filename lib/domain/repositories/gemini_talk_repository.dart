
import 'package:dartz/dartz.dart';

abstract class GeminiTalkRepository{

  Future<Either<String, String>> onTextOnly(String text);
}