/// The result of decoding bytes to a string
class DecodingResult {
  DecodingResult.fromJson(Map<String, dynamic> json)
      : this._(
          json['charset'] as String,
          json['string'] as String,
        );

  DecodingResult._(this.charset, this.string);

  /// The original charset of [string]
  final String charset;

  /// The decoded string
  final String string;
}
