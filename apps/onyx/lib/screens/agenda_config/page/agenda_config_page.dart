import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaConfigPage extends StatefulWidget {
  const AgendaConfigPage({Key? key, required this.onBack}) : super(key: key);
  final Function(int backIndex) onBack;

  @override
  State<AgendaConfigPage> createState() => _AgendaConfigPageState();
}

class _AgendaConfigPageState extends State<AgendaConfigPage> {
  late PageController _pageController;
  late ScrollController _listScrollController;
  late ScrollController _activeScrollController;
  Drag? _drag;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgendaConfigCubit(onBack: widget.onBack),
      child: BlocBuilder<AgendaConfigCubit, AgendaConfigState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("AgendaConfigState: ${state.status}");
          }
          Widget? body;
          switch (state.status) {
            case AgendaConfigStatus.initial:
              context.read<AgendaConfigCubit>().loadDirs();
              body = const StateDisplayingPage(
                  message: "Chargement de la liste des agendas");
              break;
            case AgendaConfigStatus.loading:
              body = const StateDisplayingPage(
                  message: "Chargement de la liste des agendas");
              break;
            case AgendaConfigStatus.error:
              body =
                  const StateDisplayingPage(message: "Une erreur est survenue");
              break;
            default:
              body = BlocListener<AgendaConfigCubit, AgendaConfigState>(
                listener: (context, state) {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                        (state.expandedDirs.length).toInt(),
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut);
                  }
                },
                child: WillPopScope(
                  onWillPop: () async {
                    _pageController.animateToPage(
                        _pageController.page!.toInt() - 1,
                        duration: Res.animationDuration,
                        curve: Curves.easeInOut);
                    return false;
                  },
                  child: RawGestureDetector(
                    gestures: <Type, GestureRecognizerFactory>{
                      VerticalDragGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                                  VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer(),
                              (VerticalDragGestureRecognizer instance) {
                        instance
                          ..onStart = _handleDragStart
                          ..onUpdate = _handleDragUpdate
                          ..onEnd = _handleDragEnd
                          ..onCancel = _handleDragCancel;
                      })
                    },
                    behavior: HitTestBehavior.opaque,
                    child: PageView.custom(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0) {
                            return DirWidget(
                              dir: DirModel(
                                name: "Agendas",
                                id: 0,
                                children: state.dirs,
                              ),
                              scrollController: _listScrollController,
                            );
                          } else {
                            if (state.dirs.isNotEmpty &&
                                index - 1 < state.expandedDirs.length) {
                              return DirWidget(
                                dir: state.expandedDirs[index - 1],
                                scrollController: _listScrollController,
                              );
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              );
              break;
          }

          return Scaffold(
            floatingActionButton: Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: OpenContainer<String>(
                transitionDuration: Res.animationDuration,
                openBuilder: (context, closechild) => const QrCodeScannerPage(),
                onClosed: (result) {
                  if (result != null) {
                    context
                        .read<AgendaConfigCubit>()
                        .chooseDir(AgendaConfigLogic.urlToIndex(result));
                  }
                },
                closedColor: Theme.of(context).primaryColor,
                closedShape: const CircleBorder(),
                closedBuilder: (context, openchild) => InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: openchild,
                  child: Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: Icon(
                      Icons.qr_code_rounded,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
            ),
            body: CommonScreenWidget(
              header: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.01,
                      vertical: constraints.maxWidth * 0.01),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (String query) {},
                          onSubmitted: (String query) {
                            context.read<AgendaConfigCubit>().search(query);
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                          cursorColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                            hintText: "Recherche dans les agendas",
                            prefixIcon: (state.status ==
                                    AgendaConfigStatus.searchResult)
                                ? GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AgendaConfigCubit>()
                                          .unSearch();

                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .unselectedItemColor,
                                    ),
                                  )
                                : Icon(
                                    Icons.search_rounded,
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor,
                                  ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              body: body,
            ),
          );
        },
      ),
    );
  }

  void _handleDragStart(DragStartDetails details) {
    if (_listScrollController.hasClients) {
      final RenderBox renderBox = _listScrollController
          .position.context.storageContext
          .findRenderObject() as RenderBox;
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = _pageController;
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_activeScrollController == _listScrollController &&
        details.primaryDelta! > 0 &&
        _activeScrollController.position.pixels ==
            _activeScrollController.position.minScrollExtent) {
      _activeScrollController = _pageController;
      _drag?.cancel();
      _drag = _pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drag != null) {
      _drag?.end(details);
    }
  }

  void _handleDragCancel() {
    if (_drag != null) {
      _drag?.cancel();
    }
  }

  void _disposeDrag() {
    _drag = null;
  }
}
