import 'package:cctracker/CCData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList>{

  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CC Tracker'),
      ),
      body: Container(
        child: ListView(
          children: _buildList()
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC()
      )
    );
  }

  _loadCC() async{
    final response = await http.get('https://api.coinmarketcap.com/v2/ticker/?limit=100');

    if(response.statusCode == 200){
      //print(response.body);
      var allData = (json.decode(response.body) as Map)['data'] as Map<String, dynamic>;
      var ccDataList = List<CCData>();
      allData.forEach((String key, dynamic val){
        var record = CCData(name: val['name'], symbol: val['symbol'], rank: val['rank'],
        price: val['quotes']['USD']['price']);

        ccDataList.add(record);
      });

      setState(() {
        data = ccDataList;
      });

    }
  }

  List<Widget> _buildList(){
        return data.map((CCData f) => ListTile(
          subtitle: Text(f.symbol),
          title: Text(f.name),
          leading: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AnotherPage(f.rank);
                }));
            },
            child: 
              Hero(
                tag: 'TEST' + f.rank.toString(),//different tag to hero
                child: CircleAvatar(child: Text(f.rank.toString()))
                /*child: Container(
                    height: 50.0, 
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          'https://i.ya-webdesign.com/images/pixels-drawing-pokemon-3.png'
                          )
                      )
              //CircleAvatar(child: Text(f.rank.toString()))
              ))*/)),
          trailing: Text('\$${f.price.toStringAsFixed(2)}')
          )).toList();
    }

  @override
  void initState(){
    super.initState();
    _loadCC();
  }

}


class AnotherPage extends StatelessWidget{

  int id;

  AnotherPage(int rank){
    id = rank;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
       body: Hero(
         tag: 'TEST$id',
         child: Center(
           child: Container(
             height: 300.0,
             width: 300.0,
              child: Center(child: Text(id.toString(), textScaleFactor: 10)),
                color: Colors.green[300]              
       ))),
    );
  }
}