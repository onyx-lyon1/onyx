import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:sizer/sizer.dart';

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
          Widget body;
          if (state.status == AgendaConfigStatus.loading ||
              state.status == AgendaConfigStatus.initial) {
            context.read<AgendaConfigCubit>().loadDirs();
            body = const StateDisplayingPage(
                message: "Chargement de la liste des agendas");
          } else {
            body = BlocListener<AgendaConfigCubit, AgendaConfigState>(
              listener: (context, state) {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                      (state.expandedDirs.length).toInt(),
                      duration: Res.animationDuration,
                      curve: Curves.easeInOut);
                }
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
            );
          }
          return Scaffold(
            floatingActionButton: Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const QrCodeScannerPage();
                  })).then((value) => context
                      .read<AgendaConfigCubit>()
                      .chooseDir(AgendaConfigLogic.urlToIndex(value)));
                },
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
            body: CommonScreenWidget(
              header: Container(
                margin: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: Center(
                    child: TextField(
                      onChanged: (String query) {},
                      onSubmitted: (String query) {
                        context.read<AgendaConfigCubit>().search(query);
                        FocusScope.of(context).unfocus();
                      },
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge!.color,
                      ),
                      cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Recherche dans les agendas",
                        prefixIcon: (state.status ==
                                AgendaConfigStatus.searchResult)
                            ? GestureDetector(
                                onTap: () {
                                  context.read<AgendaConfigCubit>().unSearch();

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
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
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
