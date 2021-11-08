import 'dart:convert';
import 'package:allo_thieb/help/loading.dart';
import 'package:http/http.dart' as http;
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/constants.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _total = 1;
  var _currentPerPage;
  int _currentPage = 1;
  var i = 1;
  double height = 700;
  bool _isSearch = false;
  bool isFull = true;
  List<Map<String, dynamic>> _source = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _selecteds = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> sourceCopy = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> sc2 = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> transition = <Map<String, dynamic>>[];
  List<List<Map<String, dynamic>>> elements_par_pages =
  <List<Map<String, dynamic>>>[];
  String _selectableKey = "id";
  List list = [];
  List index = [];
  String _sortColumn = "";
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;
  bool verify = true;
  var lastPerpage;

  _perpage_save(int perpage) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    lastPerpage = await preferences.getInt('lastPerpage');
    if (lastPerpage == null || lastPerpage == 0) {
      await preferences.setInt('lastPerpage', 10);
      lastPerpage = await preferences.getInt('lastPerpage');
      return lastPerpage;
    } else {
      if (perpage != 0) {
        await preferences.setInt('lastPerpage', perpage);
        lastPerpage = await preferences.getInt('lastPerpage');
      }
      return lastPerpage;
    }
  }

  List<Map<String, dynamic>> _generateData(list) {
    List<Map<String, dynamic>> temps = <Map<String, dynamic>>[];
    for (var data in list) {
      temps.add({
        "id": i,
        "nom": data['userInfo']['nom'],
        "livraison": data['typeLivraison'],
        "heure": "00 min-1",
      });
      i++;
    }
    return temps;
  }

  _nombre_de_pages(int nombre_par_page, int nombre_de_commandes) {
    int ajout = 0;
    int ndp = 0;
    int ndc = nombre_de_commandes;
    while (ajout < ndc) {
      ajout += nombre_par_page;
      if (nombre_de_commandes < nombre_par_page) {
        nombre_de_commandes -= nombre_de_commandes;
        ndp++;
      } else {
        nombre_de_commandes -= nombre_par_page;
        ndp++;
      }
    }
    // if (nombre_de_commandes > 0) {
    //   ndp++;
    // }
    return ndp;
  }

  _initData() async {
    setState(() => _isLoading = true);
    final http.Response response1 = await http.get(Uri.parse(apiNombre));
    if (response1.statusCode == 200) {
      index = jsonDecode(response1.body);
      for (var i in index) {
        final http.Response response =
        await http.get(Uri.parse(apiCommandeRecente + "/$i"));
        if (response.statusCode == 200) {
          list.add(jsonDecode(response.body));
          setState(() {
            var aa = _generateData(list);
            if (_source.length < lastPerpage.toInt() || _source == null) {
              _source.addAll(aa);
            }
            sc2.addAll(aa);
            verify = false;
            list = [];
          });
        }
      }
      sourceCopy = sc2;
      pagination(lastPerpage.toInt());
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    lastPerpage = _perpage_save(0);
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
                BoxShadow(color: Colors.white, offset: Offset(0, 3), blurRadius: 4)
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
                    color: Colors.white,
                    elevation: 1,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: verify
                        ? Loading()
                        : ResponsiveDatatable(
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
                                        icon: Icon(Icons.search),
                                        onPressed: () {})),
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
                            _source.sort((a, b) => b["$_sortColumn"]
                                .compareTo(a["$_sortColumn"]));
                          } else {
                            _source.sort((a, b) => a["$_sortColumn"]
                                .compareTo(b["$_sortColumn"]));
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
                          setState(() =>
                              _selecteds.removeAt(_selecteds.indexOf(item)));
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
                          child: Text(
                            "Elements par page:",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_perPages != null) buildIgnorePointer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("$_currentPage sur $_total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: () {
                            if (!isFull) {
                              setState(() {
                                _currentPage =
                                _currentPage >= 2 ? _currentPage - 1 : 1;
                                _source = [];
                                _source.addAll(
                                    elements_par_pages[_currentPage - 1]);
                              });
                            }
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            if (!isFull) {
                              setState(() {
                                if (_currentPage < _total) {
                                  _currentPage++;
                                  _source = [];
                                  _source.addAll(
                                      elements_par_pages[_currentPage - 1]);
                                }
                              });
                            }
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }

  Widget buildIgnorePointer() {
    Container ddown = Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButton(
          value: lastPerpage,
          items: _perPages
              .map((e) => DropdownMenuItem(
            child: Text("$e"),
            value: e,
          ))
              .toList(),
          onChanged: pagination),
    );
    return _isLoading ? IgnorePointer(child: ddown) : ddown;
  }

  void pagination(value) {
    setState(() {
      elements_par_pages = [];
      lastPerpage = (value) as int;
      _perpage_save(lastPerpage);
      transition = [];
      int a = lastPerpage.toInt();
      _total = _nombre_de_pages(a, sourceCopy.length);
      if (lastPerpage >= sourceCopy.length) {
        isFull = true;
        for (var i = 0; i < sourceCopy.length; i++) {
          transition.add(sourceCopy[i]);
        }
        _source = transition;
      } else {
        isFull = false;
        for (var i = 0; i < lastPerpage; i++) {
          transition.add(sourceCopy[i]);
        }
        _source = transition;
        int idx = 0;
        int currentIdx = 0;
        for (var j = 0; j < _total; j++) {
          List<Map<String, dynamic>> page_items = <Map<String, dynamic>>[];
          if (idx == lastPerpage) {
            idx = 0;
            if (sourceCopy.length - currentIdx < lastPerpage) {
              for (var i = currentIdx; i < sourceCopy.length; i++) {
                page_items.add(sourceCopy[i]);
                idx++;
              }
            } else {
              for (var i = currentIdx; i < currentIdx + lastPerpage; i++) {
                page_items.add(sourceCopy[i]);
                idx++;
              }
              currentIdx += idx;
            }
          } else {
            for (var i = 0; i < lastPerpage; i++) {
              page_items.add(sourceCopy[i]);
              idx++;
            }
            currentIdx += idx;
          }
          elements_par_pages.add(page_items);
        }
        print(elements_par_pages);
      }
    });
  }
}
