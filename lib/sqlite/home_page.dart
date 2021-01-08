import 'package:sexta_integrada/sqlite/db_provider.dart';
import 'package:sexta_integrada/sqlite/employee_api_provider.dart';
import 'package:flutter/material.dart';

class HomePageSqlite extends StatefulWidget {
  const HomePageSqlite({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSqlite> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.grey,
        title: Text('Api to sqlite', style: TextStyle(color: Colors.red),),
        centerTitle: true,
        actions: <Widget>[
          Container(
            color: Colors.grey,
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              color: Colors.red,
              icon: Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.red,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
                title: Text(
                    "Name: ${snapshot.data[index].firstName} ${snapshot.data[index].lastName} ",
                    style: TextStyle(color: Colors.red),
                    ),
                subtitle: Text('Region: ${snapshot.data[index].email}',
                style: TextStyle(color: Colors.red),
                ),
              );
            },
          );
        }
      },
    );
  }
}
