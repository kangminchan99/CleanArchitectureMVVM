import 'package:cleanarchitecture/src/core/network/error/failures.dart'; // Importing failure classes for error handling
import 'package:cleanarchitecture/src/core/utils/constant/app_constant.dart'; // Importing constants
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart'; // Importing the article model
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart'; // Importing parameters for use case
import 'package:cleanarchitecture/src/features/articles/domain/usecases/articles_usecase.dart'; // Importing the use case for articles
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing Bloc for state management

part 'articles_event.dart'; // Part file for events
part 'articles_state.dart'; // Part file for states

// BLoC이 사용자 행동을 포착하도록 설정되었고, 이는 기사 관련 유스케이스를 호출하며, 유스케이스는 데이터를 가져오기 위해 리포지토리 계층과 통신
class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesUsecase articlesUseCase; // 의존성 주입을 위한 유스케이스

  // 기사 리스트
  List<ArticleModel> allArticles = []; // 유스케이스에서 가져온 모든 기사 저장

  ArticlesBloc({required this.articlesUseCase})
    : super(LoadingGetArticlesState()) {
    // 초기 상태는 로딩 상태
    on<OnGettingArticlesEvent>(_onGettingArticlesEvent); // 기사 가져오기 이벤트 핸들러 등록
    on<OnSearchingArticlesEvent>(_onSearchingEvent); // 기사 검색 이벤트 핸들러 등록
  }

  // 기사 가져오기 이벤트 핸들러
  _onGettingArticlesEvent(
    OnGettingArticlesEvent event, // 기사 가져오기 이벤트
    Emitter<ArticlesState> emitter, // UI로 상태를 전달
  ) async {
    if (event.withLoading) {
      // 로딩 상태를 표시해야 하는지 확인
      emitter(LoadingGetArticlesState()); // 로딩 상태 방출
    }

    final result = await articlesUseCase.call(
      ArticlesParams(period: event.period), // 주어진 기간으로 유스케이스 호출
    );
    result.fold(
      (l) {
        // 실패 처리
        if (l is CancelTokenFailure) {
          // 취소로 인한 실패인 경우
          emitter(LoadingGetArticlesState()); // 다시 로딩 상태 방출
        } else {
          emitter(ErrorGetArticlesState(l.errorMessage)); // 에러 메시지와 함께 에러 상태 방출
        }
      },
      (r) {
        // 성공 처리
        allArticles = r; // 기사 리스트 업데이트
        emitter(
          SuccessGetArticlesState(_runFilter(event.text)),
        ); // 필터링된 기사와 함께 성공 상태 방출
      },
    );
  }

  // 기사 검색 이벤트 핸들러
  _onSearchingEvent(
    OnSearchingArticlesEvent event, // 검색 텍스트를 포함한 이벤트
    Emitter<ArticlesState> emitter, // UI로 상태를 전달
  ) async {
    emitter(SearchingState(_runFilter(event.text))); // 필터링된 기사와 함께 검색 상태 방출
  }

  // 검색 텍스트를 기반으로 기사를 필터링하는 함수
  List<ArticleModel> _runFilter(String text) {
    List<ArticleModel> results = []; // 결과 리스트 초기화
    if (text.isEmpty) {
      // 검색 텍스트가 비어있는 경우
      results = List.from(allArticles); // 모든 기사 반환
    } else {
      results = allArticles.where((user) {
        // 제목으로 기사 필터링
        return (user.title ?? defaultStr).toLowerCase().contains(
          text.toLowerCase(), // 제목에 검색 텍스트가 포함되어 있는지 확인
        );
      }).toList();
    }
    return results; // 필터링된 리스트 반환
  }
}
