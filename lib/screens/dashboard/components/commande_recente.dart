import 'dart:math';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';


class DataPage extends StatefulWidget {

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nom",
        value: "nom",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Type Livraison",
        value: "livraison",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Heure",
        value: "heure",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),

  ];

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  var _currentPerPage ;
  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _source = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _selecteds = <Map<String, dynamic>>[];
  String _selectableKey = "id";

  String _sortColumn = "";
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  List<Map<String, dynamic>> _generateData({int n= 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = <Map<String, dynamic>>[];
    var i = _source.length;
    print(i);
    for (var data in source) {
      temps.add({
        "id": i,
        "nom": "User Name $i",
        "livraison": "Type livraison $i",
        "heure": "00 min-$i",
      });
      i++;
    }
    return temps;
  }


  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 2)).then((value) {
      _source.addAll(_generateData(n: 17)); //1000
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),

                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 3), blurRadius: 4)
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: CustomText(
                      color: blueFont,
                      text: "Commandes récentes",
                      size: 20,
                      weight: FontWeight.bold,

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(
                      maxHeight: 700,
                    ),
                    child: Card(
                      elevation: 1,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.none,
                      child: ResponsiveDatatable(
                        title: !_isSearch
                            ? RaisedButton.icon(
                            onPressed: () {
                              _initData();
                            },
                            icon: Icon(Icons.add),
                            label: Text("ADD"))
                            : null,
                        actions: [
                          if (_isSearch)
                            Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              _isSearch = false;
                                            });
                                          }),
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.search), onPressed: () {})),
                                )),
                          if (!_isSearch)
                            IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = true;
                                  });
                                })
                        ],
                        headers: _headers,
                        source: _source,
                        selecteds: _selecteds,
                        showSelect: _showSelect,
                        autoHeight: false,
                        onTabRow: (data) {
                          print(data);
                        },
                        onSort: (value) {
                          setState(() {
                            _sortColumn = value;
                            _sortAscending = !_sortAscending;
                            if (_sortAscending) {
                              _source.sort((a, b) =>
                                  b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                            } else {
                              _source.sort((a, b) =>
                                  a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                            }
                          });
                        },
                        sortAscending: _sortAscending,
                        sortColumn: _sortColumn,
                        isLoading: _isLoading,
                        onSelect: (value, item) {
                          print("$value  $item ");
                          if (value) {
                            setState(() => _selecteds.add(item));
                          } else {
                            setState(
                                    () => _selecteds.removeAt(_selecteds.indexOf(item)));
                          }
                        },
                        onSelectAll: (value) {
                          if (value) {
                            setState(() => _selecteds =
                                _source.map((entry) => entry).toList().cast());
                          } else {
                            setState(() => _selecteds.clear());
                          }
                        },
                        footers: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Elements par page:",overflow: TextOverflow.ellipsis,),
                          ),
                          if (_perPages != null)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton(
                                  value: _currentPerPage,
                                  items: _perPages
                                      .map((e) => DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _currentPerPage = (value) as int;
                                    });
                                  }),
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child:
                            Text("$_currentPage - $_currentPerPage sur $_total"),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                _currentPage =
                                _currentPage >= 2 ? _currentPage - 1 : 1;
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, size: 16),
                            onPressed: () {
                              setState(() {
                                _currentPage++;
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          )
      );
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _initData();
      //   },
      //   child: Icon(Icons.add),
      // ),

  }
}
