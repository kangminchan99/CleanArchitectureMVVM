class ArticlesParams {
  ArticlesParams({required this.period});

  // 나중에 초기화 가능하도록 설정
  late final int period;

  // json 데이터를 객체로 변환
  ArticlesParams.fromJson(Map<String, dynamic> json) {
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['period'] = period;
    return data;
  }
}
