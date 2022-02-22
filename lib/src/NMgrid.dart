import 'package:flutter/material.dart';

typedef bool WillNotifySearch(
    String lastSearchInput, String currentSearchInput);

typedef TextStyle DynamicPaginationStyle(int pageNumber);

///The main class. Use it like
class NMGrid extends StatefulWidget {
  ///A key for the Widget
  final Key? key;

  ///The whole width of the NMGrid widget
  final double? width;

  ///Theme to apply to the grid. If it's not supplied will use upper theme's such as the very
  ///MaterialApp theme
  final ThemeData? themeData;

  ///The whole height of the NMGrid widget
  final double? height;

  ///The height? of the header line
  final double? headerHeight;
  final Function? onTapHeader;
  final List<dynamic>? headerColumns;
  final List<List<dynamic>>? data;
  final Future<List<List<dynamic>>> Function()? dataAsync;
  final Future<List<List>> Function(String)? onSearch;

  ///The percentage of the whole width that the column has to take. If null,
  ///will distribute all columns equally
  final List<double>? columnWidthsPercentages;
  final List<int>? columnFlex;

  final Future<List<List>> Function(int)? onPaginationItemClick;
  final Color Function(int)? headerCellsColor;
  final Color? rowBackgroundColor;

  ///Called on asynchronous errors such as on onSearch or onPaginationItemClick methods
  final Function(dynamic)? onError;

  final double Function(int)? heightByRow;

  final Alignment Function(int, int)? alignmentByRow;

  final Alignment Function(int)? headerAlignmentByCells;

  ///Max number of pages starting on page 1
  final int? maxPages;

  ///The current page that is beign ehxibited
  final int? curPage;

  ///Custom style to apply to the rows
  final TextStyle? rowsStyle;

  ///Custom style to apply to the pagination item buttons
  final TextStyle? paginationStyle;

  ///A function that takes in a page number (starting from 1 not zero), and returns a style to use in
  ///the button that triggers that page
  final DynamicPaginationStyle? paginationDynamicStyle;

  ///Custom style to apply to the header cells
  final TextStyle? headerStyle;

  ///A style for the "zebra effect affected" rows in case parameter [applyZebraEffect] is set to true
  final TextStyle? zebraStyle;

  ///Render the widgetas a Card
  final bool asCard;

  ///Marks to use zebra effect on rows
  final bool applyZebraEffect;

  ///Reverts the zebra effect to apply the effect on odd or even indexes
  final bool invertZebra;

  ///Marks if the NMGrid should show or not inner grid lines
  final bool internalGrid;

  ///Padding to be applied on the search bar in case parameter [showSearchBar] is
  ///set to true
  final EdgeInsets searchBarPadding;

  ///Padding to be applied on every and each header cell
  final EdgeInsets headerCellsPadding;

  ///Padding to be applied on every and each row cell
  final EdgeInsets rowCellsPadding;

  ///Wheather to show or not the searchbar
  final bool showSearchBar;

  ///Input decoration for the searchbar widget
  ///```dart
  ///NMGrid(
  ///   searchBarInputDecoration: InputDecoration(
  ///       border: OutlineInputBorder(),
  ///       fillColor: Colors.blueGrey,
  ///   ),
  ///)
  ///```
  final InputDecoration searchBarInputDecoration;

  final int? sortColumnIndex;
  final bool? sortAscending;

  ///A style to apply on the searchbar
  final TextStyle searchBarStyle;

  ///Searchbar text align property
  final TextAlign searchBarTextAlign;

  ///The height for the searchbar widget
  final double searchBarHeight;

  ///Auto focus property for the search field if [showSearchBar] is set to true
  final bool searchFieldAutoFocus;

  final WillNotifySearch? notifySearchOnlyIf;

  ///A period to wait from the time the user starts typing to in fact the
  ///time the widget will notify an onSearchType event so that it would not update
  ///for every character typed or deleted. The period is in milliseconds
  final int? searchInterval;

  ///If rendering as a Card, sets the internal padding from the edge of the
  final EdgeInsets asCardPadding;

  ///Widget to display when theres no registers to display
  final Widget? noContentWidget;

  ///A function that receives the index of the cell, the content and
  ///returns a widget to render the content of that cell
  final Widget Function(int row, int cell, dynamic)? rowsCellRenderer;

  ///A function that receives the index of the header cell, the content and
  ///returns a widget to render the content of that cell
  final Widget Function(int, dynamic)? headerCellRenderer;

  static const baseSearchBarInputDecoration = InputDecoration(
    suffixIcon: Icon(Icons.search, size: 16),
    contentPadding: EdgeInsets.only(bottom: 12, left: 4),
    hintText: 'Search...',
    border: UnderlineInputBorder(),
    filled: true,
  );

  static const baseSearchBarPadding =
      const EdgeInsets.only(left: 180, top: 5, bottom: 5, right: 0);
  static const baseAsCardPadding = const EdgeInsets.all(0);
  static const baseHeaderCellsPadding = EdgeInsets.only(left: 10);
  static const baseRowCellsPadding =
      EdgeInsets.only(left: 10, top: 5, bottom: 5);

  static const baseSearchBarStyle = const TextStyle(fontSize: 14);
  static const baseHeaderStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const baseRowStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const baseZebraStyle = TextStyle(
      fontSize: 14, color: Colors.black87, fontWeight: FontWeight.normal);
  static const basePaginationStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.normal);

  NMGrid(
      {this.key,
      this.width,
      this.height,
      this.rowBackgroundColor,
      this.headerHeight = 50,
      this.columnWidthsPercentages,
      @required this.columnFlex,
      @required this.headerColumns,
      this.maxPages,
      this.curPage,
      this.headerCellsPadding = baseHeaderCellsPadding,
      this.applyZebraEffect = true,
      this.rowCellsPadding = baseRowCellsPadding,
      this.zebraStyle = baseZebraStyle,
      this.invertZebra = false,
      this.searchBarPadding = baseSearchBarPadding,
      this.searchBarInputDecoration = baseSearchBarInputDecoration,
      this.searchBarHeight = 20,
      this.searchBarStyle = baseSearchBarStyle,
      this.showSearchBar = true,
      this.notifySearchOnlyIf,
      this.searchInterval,
      this.themeData,
      this.asCard = true,
      this.internalGrid = false,
      this.searchBarTextAlign = TextAlign.start,
      this.asCardPadding = baseAsCardPadding,
      this.headerStyle = baseHeaderStyle,
      this.rowsStyle = baseRowStyle,
      this.paginationStyle = basePaginationStyle,
      this.paginationDynamicStyle,
      this.headerAlignmentByCells,
      this.alignmentByRow,
      this.data,
      this.dataAsync,
      this.headerCellRenderer,
      this.headerCellsColor,
      this.heightByRow,
      this.noContentWidget,
      this.onSearch,
      this.searchFieldAutoFocus = false,
      this.onPaginationItemClick,
      this.rowsCellRenderer,
      this.onError,
      this.sortAscending,
      this.onTapHeader,
      this.sortColumnIndex}) {
    if (headerColumns == null)
      throw Exception(_logError('Headers can\'t be null'));
    // if (columnWidthsPercentages != null &&
    //     columnWidthsPercentages.length > headerColumns.length)
    //   throw Exception(_logError(
    //       'columnWidthsPercentages length can\'t be greater than headerColumns length'));
    // if (columnWidthsPercentages != null &&
    //     columnWidthsPercentages.reduce((value, element) => value + element) >
    //         100)
    //   throw Exception(_logError('columnWidth\'s sum is greather than 100'));
  }

  String _logError(String error) {
    return '[NMGrid] $error';
  }

  @override
  _NMGridState createState() => _NMGridState();
}

class _NMGridState extends State<NMGrid> {
  String lastSearch = '';
  int? lastMilliseconds;
  List<List>? _data;
  bool? sortByASC;
  // var _searchController = TextEditingController(text: '');
  double? maxWidth;
  // final _cardWidgetKey = GlobalKey();
  // Size _cardWidgetSize;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    if (_data == null && widget.dataAsync != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        widget.dataAsync!().then((dataReturned) {
          setState(() {
            _data = dataReturned;
            sortByASC = widget.sortAscending;
          });
        });
      });
    }
    lastMilliseconds = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.themeData != null) {
      return Theme(data: widget.themeData!, child: _getWidget());
    }
    return _getWidget();
  }

  Widget _getWidget() {
    if (widget.asCard)
      return Container(
        key: widget.key,
        child: Padding(
          padding: widget.asCardPadding,
          child: content,
        ),
      );
    return content;
  }

  Widget get content => Column(
        children: <Widget>[
          Container(
            child: _tableHeader(),
            // color: lightDefaultBG,
          ),
          Container(height: 1, color: Colors.transparent),
          _data != null && _data!.length > 0
              ? Expanded(child: _tableRows())
              : widget.noContentWidget ??
                  Container(
                    decoration: BoxDecoration(
                      border: _makeBorder(
                        top: false,
                        left: true,
                        bottom: true,
                        right: true,
                      ),
                    ),
                    width: double.infinity,
                    height: 100.0,
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text('No data found.'),
                    ),
                  ),
        ],
      );

  /*Widget _searchBar() {
    return Padding(
      padding: widget.searchBarPadding,
      child: Container(
        height: widget.searchBarHeight,
        child: TextFormField(
          autofocus: widget.searchFieldAutoFocus,
          controller: _searchController,
          textAlign: widget.searchBarTextAlign,
          onChanged: (typed) {
            //if the widget.onSearch was not passed, nothing else should execute
            if (widget.onSearch != null) {
              _handleSearchEvent(typedText: typed);
            }
          },
          style: widget.searchBarStyle,
          decoration: widget.searchBarInputDecoration,
        ),
      ),
    );
  }*/

  ///Decides if the widget.onSearch event will or will not be called
  ///depending on the widget.searchInterval and widget.notifyOnlyIf parameters
  /*void _handleSearchEvent({String typedText}) async {
    //if the interval is not completed will not call the widget.onSearch
    if (_completedInterval) {
      //once completed, resets it
      setState(() {
        _resetSearchInterval();
      });

      //if the call of typedTex contains the same text of the previous call or
      //if the call came from a schedule and the current _searchController.text is
      //already equals to the last search, ignore the event
      if (typedText == lastSearch ||
          (typedText == null &&
              _searchController.text.isNotEmpty &&
              _searchController.text == lastSearch)) {
        return;
      }

      //if the widget.notifySearchOnlyIf is passed, checks it
      if (widget.notifySearchOnlyIf == null ||
          (widget.notifySearchOnlyIf != null &&
              widget.notifySearchOnlyIf(lastSearch, typedText))) {
        //will call the widget.onSearch
        widget.onSearch(typedText ?? _searchController.text).then((newData) {
          //if newData came from the widget.onSearch
          if (newData != null) {
            setState(() {
              _data = newData;
            });
          }
        }).catchError((error) {
          _throwError(error);
        });
      }
    } else {
      //if the _handleSearchEvent is called whithin the search interval, schedules a new try
      Future.delayed(
        Duration(milliseconds: widget.searchInterval - elapsedMilliseconds),
      )
          .then(
        (value) => _handleSearchEvent(),
      )
          .catchError((error) {
        _throwError(error);
      });
    }
  }*/

  /*void _throwError(dynamic error) {
    if (widget.onError != null) widget.onError(error);
  }*/

  /*///Resets the search interval making it equals to the current millisecondsSinceEpoch
  void _resetSearchInterval() {
    lastMilliseconds = DateTime.now().millisecondsSinceEpoch;
  }*/

  /*///if the widget.searchInterval argument was provided, checks if the
  ///elapsed time is already bigger than or equals to the given value
  bool get _completedInterval {
    if (widget.searchInterval != null)
      return elapsedMilliseconds >= widget.searchInterval;
    return true;
  }*/

  ///measures the elapsed time
  int get elapsedMilliseconds =>
      DateTime.now().millisecondsSinceEpoch - lastMilliseconds!;

  ///Builds the table header
  Widget _tableHeader() {
    return IntrinsicHeight(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(widget.headerColumns!.length, (i) {
        bool left = i == 0, right = true;
        Widget? cellWidget = widget.headerCellRenderer != null
            ? widget.headerCellRenderer!(i, widget.headerColumns![i])
            : null;

        print("cellWidget");
        print(cellWidget);
        return Expanded(
            flex: widget.columnFlex![i],
            child: Container(
              // height: widget.headerHeight,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.headerCellsColor != null
                    ? widget.headerCellsColor!(i)
                    : null,
                border: _makeBorder(
                  top: widget.internalGrid ? true : false,
                  left: widget.internalGrid ? left : false,
                  bottom: false,
                  right: widget.internalGrid ? right : false,
                ),
              ),
              child: InkWell(
                  onTap: () {
                    print(widget.sortAscending);
                    widget.onTapHeader!(widget.sortAscending, i);
                  },
                  child: cellWidget != null
                      ? cellWidget
                      : widget.headerColumns![i] is Widget
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Expanded(child: widget.headerColumns![i]),
                                ])
                          : Row(
                              children: [
                                Text(widget.headerColumns![i].toString(),
                                    style: widget.headerStyle),
                              ],
                            )),
              // :  Text(widget.headerColumns[i].toString(),
              //     style: widget.headerStyle)),
              // child:  cellWidget != null
              //     ? cellWidget
              //     :  widget.headerColumns[i] is Widget
              //         ? widget.headerColumns[i]
              //         : Text(widget.headerColumns[i].toString(),
              //             style: widget.headerStyle),
            ));
        // Container(
        //   width: _getColumnWidth(i),
        //   height: widget.headerHeight,
        //   alignment: widget.headerAlignmentByCells != null
        //       ? widget.headerAlignmentByCells(i)
        //       : Alignment.centerLeft,
        //   decoration: BoxDecoration(
        //     color: widget.headerCellsColor != null
        //         ? widget.headerCellsColor(i)
        //         : null,
        //     border: _makeBorder(
        //       top: widget.internalGrid ? true : false,
        //       left: widget.internalGrid ? left : false,
        //       bottom: false,
        //       right: widget.internalGrid ? right : false,
        //     ),
        //   ),
        //   child: Padding(
        //     padding: widget.headerCellsPadding,
        //     child: cellWidget != null
        //         ? cellWidget
        //         : widget.headerColumns[i] is Widget
        //             ? widget.headerColumns[i]
        //             : Text(widget.headerColumns[i].toString(),
        //                 style: widget.headerStyle),
        //   ),
        // );
      }),
    ));
  }

  ///Builds a table row
  _makeRow(
    List cells, {
    bool top = true,
    bool bottom = true,
    bool zebra = false,
    int? rowNumber,
    TextStyle? style,
  }) {
    List<Widget> cellWidgets = List.generate(
      cells.length,
      (i) {
        bool left = i == 0, right = true;
        var _style =
            widget.applyZebraEffect && zebra ? widget.zebraStyle : style;
        Widget? cellWidget = widget.rowsCellRenderer != null
            ? widget.rowsCellRenderer!(rowNumber!, i, cells[i])
            : null;
        if (cellWidget == null) {
          cellWidget = cells[i] is Widget
              ? cells[i]
              : Text(cells[i].toString(), style: _style ?? widget.rowsStyle);
        }
        return Expanded(
            flex: widget.columnFlex![i],
            child: Container(
              decoration: BoxDecoration(
                  color:
                      widget.applyZebraEffect && zebra ? Colors.black38 : null,
                  // boxShadow: widget.applyZebraEffect && zebra
                  //     ? [BoxShadow(color: Colors.grey[200])]
                  //     : null,
                  border:
                      // border: Border(
                      //   left: BorderSide(
                      //     //                   <--- left side
                      //     color: Colors.black,
                      //     width: 1.0,
                      //   ),
                      //   top: BorderSide(
                      //     //                    <--- top side
                      //     color: Colors.black,
                      //     width: 1.0,
                      //   ),
                      // ),
                      _makeBorder(
                    top: false,
                    left: widget.internalGrid ? left : false,
                    bottom: widget.internalGrid ? bottom : false,
                    right: widget.internalGrid ? right : false,
                  )),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: cellWidget,
              ),
            ));

        //  Container(
        //   height:
        //       widget.heightByRow != null ? widget.heightByRow(rowNumber) : null,
        //   width: _getColumnWidth(i),
        //   alignment: widget.alignmentByRow != null
        //       ? widget.alignmentByRow(rowNumber, i)
        //       : Alignment.centerLeft,
        //   decoration: BoxDecoration(
        //       boxShadow: widget.applyZebraEffect && zebra
        //           ? [BoxShadow(color: Colors.grey[200])]
        //           : null,
        //       border: _makeBorder(
        //         top: false,
        //         left: widget.internalGrid ? left : false,
        //         bottom: widget.internalGrid ? bottom : false,
        //         right: widget.internalGrid ? right : false,
        //       )),
        //   child: Padding(
        //     padding: widget.rowCellsPadding,
        //     child: cellWidget,
        //   ),
        // );
      },
    );
    // return Row(
    //   // mainAxisSize: MainAxisSize.max,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: cellWidgets,
    // );
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: cellWidgets,
    ));
  }

  ///Creates the border of the container for each cell
  Border _makeBorder({
    bool top = true,
    bool left = true,
    bool right = true,
    bool bottom = true,
    Color borderColor = Colors.black38,
    double width = 0.5,
  }) =>
      Border(
        left: left ? _border(borderColor, width) : BorderSide.none,
        top: top ? _border(borderColor, width) : BorderSide.none,
        right: right ? _border(borderColor, width) : BorderSide.none,
        bottom: bottom ? _border(borderColor, width) : BorderSide.none,
      );

  BorderSide _border([Color? color, double? width]) =>
      BorderSide(color: color!, width: width!);

  ///Builds all the rows
  Widget _tableRows() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _data!.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        height: 1,
        color: Colors.black26,
      ),
      itemBuilder: (ctx, i) => _makeRow(
        _data![i],
        top: false,
        zebra: widget.invertZebra ? i % 2 != 0 : i % 2 == 0,
        rowNumber: i,
      ),
    );
  }

  /*///Builds the pagination widget
  Widget _pagination() {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        decoration: BoxDecoration(
            border: widget.internalGrid
                ? null
                : Border(top: BorderSide(width: 0.7, color: Colors.black54))),
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (ctx, i) =>
                Container(width: widget.paginationStyle.fontSize / 2),
            itemCount: widget.maxPages,
            itemBuilder: (ctx, index) {
              var i = index + 1;
              var style = widget.paginationStyle;
              if (i != widget.curPage)
                style = style.copyWith(color: Colors.blue);

              //if a dynamic pagination style is passed, replaces the current one
              if (widget.paginationDynamicStyle != null) {
                style = widget.paginationDynamicStyle(i);
              }

              return Container(
                child: _pageNumberWidget(i, style: style),
                width: (widget.width /
                        (style.fontSize ??
                            NMGrid.basePaginationStyle.fontSize) /
                        2) +
                    ((style.fontSize ?? NMGrid.basePaginationStyle.fontSize) *
                        i.toString().length),
              );
            }),
      ),
    );
  }*/

  /*///Builds the page number
  Widget _pageNumberWidget(int i, {TextStyle style}) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      onPressed: i != widget.curPage && widget.onPaginationItemClick != null
          ? () => _handlePaginationClick(i)
          : null,
      visualDensity: VisualDensity(horizontal: 1),
      child: Text(i.toString(), style: style),
    );
  }*/

  /*///Performs the widget.onPaginationItemClick and in an await
  ///call and if it returns new data, updates the data
  void _handlePaginationClick(int i) {
    widget.onPaginationItemClick(i).then((newData) {
      if (newData != null) {
        setState(() {
          _data = newData;
        });
      }
    }).catchError((error) {
      _throwError(error);
    });
  }*/

  /*///returns the width of each column by it's index
  double _getColumnWidth(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    // _getSize();

    return widget.columnWidthsPercentages != null &&
            widget.columnWidthsPercentages.length >= widget.headerColumns.length
        ? widget.columnWidthsPercentages[index] / 100 * maxWidth
        : maxWidth / widget.headerColumns.length;
  }*/

  /*int getFlex(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    // _getSize();

    return widget.columnWidthsPercentages != null &&
            widget.columnWidthsPercentages.length >= widget.headerColumns.length
        ? (widget.columnWidthsPercentages[index] / 10).toInt()
        : (10 / widget.headerColumns.length).toInt();
  }*/
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      left: BorderSide(
        //                   <--- left side
        color: Colors.black,
        width: 3.0,
      ),
      top: BorderSide(
        //                    <--- top side
        color: Colors.black,
        width: 3.0,
      ),
    ),
  );
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
