import 'package:cleanarchitecture/src/core/helper/helper.dart';
import 'package:cleanarchitecture/src/core/translations/l10n.dart';
import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/usecases/articles_usecase.dart';
import 'package:cleanarchitecture/src/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:cleanarchitecture/src/features/articles/presentation/widgets/article_card_widget.dart';
import 'package:cleanarchitecture/src/shared/presentation/pages/background_page.dart';
import 'package:cleanarchitecture/src/shared/presentation/widgets/app_loader.dart';
import 'package:cleanarchitecture/src/shared/presentation/widgets/custom_app_bar_widget.dart';
import 'package:cleanarchitecture/src/shared/presentation/widgets/reload_widget.dart';
import 'package:cleanarchitecture/src/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final ArticlesBloc _bloc = ArticlesBloc(
    articlesUseCase: sl<ArticlesUsecase>(),
  );

  // key for scaffold to open drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // refresh controller for list view
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  bool isSearching = false;

  // list of articles
  List<ArticleModel> nyTimesArticles = [];

  // search text controller
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // period
  int selectedPeriod = 1;

  @override
  void initState() {
    callArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      scaffoldKey: _key,
      withDrawer: true,
      child: Column(
        children: [
          // custom app bar
          CustomAppBarWidget(
            title: isSearching
                ? TextFieldWidget(
                    controller: _searchTextController,
                    focusNode: _searchFocusNode,
                    hintText: S.of(context).search,
                    onChanged: (value) {
                      _bloc.add(OnSearchingArticlesEvent(value?.trim() ?? ''));
                    },
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                          if (isSearching) {
                            _searchFocusNode.requestFocus();
                          } else {
                            _searchFocusNode.unfocus();
                            _searchTextController.clear();
                            callArticles();
                          }
                        });
                      },
                      icon: Icon(Icons.close, size: 20),
                    ),
                  )
                : Text(
                    S.of(context).ny_times_most_popular,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, size: 20),
            ),
            actions: [
              if (!isSearching) ...{
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                      if (isSearching) {
                        _searchFocusNode.requestFocus();
                      } else {
                        _searchFocusNode.unfocus();
                        _searchTextController.clear();
                        callArticles();
                      }
                    });
                  },
                  icon: Icon(Icons.search, size: 20),
                ),
              },

              // Menu
              PopupMenuButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onSelected: (value) {
                  selectedPeriod = int.tryParse(value) ?? 1;
                  callArticles();
                },
                elevation: 3,
                tooltip: S.of(context).period,
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: '1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 1) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '7',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "7",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 7) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '30',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "30",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 30) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                  ];
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).period,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: 1.sp),
                    Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: Helper.getVerticalSpace()),
          Expanded(
            child: BlocConsumer<ArticlesBloc, ArticlesState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is SuccessGetArticlesState) {
                  nyTimesArticles.clear();
                  nyTimesArticles = List.from(state.articles);
                  _refreshController.refreshCompleted(resetFooterState: true);
                } else if (state is SearchingState) {
                  nyTimesArticles.clear();
                  nyTimesArticles = state.articles;
                }
              },
              builder: (context, state) {
                if (state is LoadingGetArticlesState) {
                  return const AppLoader();
                } else if (state is ErrorGetArticlesState) {
                  return ReloadWidget.error(
                    content: state.errorMsg,
                    onPressed: () {
                      callArticles();
                    },
                  );
                }

                // Check if there is no data
                if (nyTimesArticles.isEmpty) {
                  return ReloadWidget.empty(content: S.of(context).no_data);
                }

                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Theme.of(context).cardColor,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: null,
                  child: ListView.builder(
                    itemCount: nyTimesArticles.length,
                    itemBuilder: (context, index) {
                      return ArticleCardWidget(
                        nyTimesModel: nyTimesArticles[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Refresh method called when pull down list
  void _onRefresh() async {
    _refreshController.requestRefresh();
    callArticles(withLoading: false);
  }

  // Call articles
  callArticles({bool withLoading = true}) {
    _bloc.add(
      OnGettingArticlesEvent(
        _searchTextController.text.trim(),
        selectedPeriod,
        withLoading: withLoading,
      ),
    );
  }
}
