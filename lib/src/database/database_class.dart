import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Databases {
  PostgreSQLConnection? connection;
  PostgreSQLResult? saveDetailsResult;

  Databases() {
    /*..Create Postgres Connection....*/
    connection = (connection == null || connection!.isClosed == true
        ? PostgreSQLConnection('10.0.2.2', 5432, 'special',
            username: 'admin_special',
            password: 'asad1122',
            timeoutInSeconds: 30,
            timeZone: 'UTC',
            useSSL: false,
            isUnixSocket: false,
            queryTimeoutInSeconds: 30)
        : connection);
  }

  String? dataSavedFuture;
  Future<String?>? saveDetails(
      String? productName, String? videoLink, String? imageData) async {
    try {
      await connection!.open();
      await connection!.transaction((conn) async {
        print('here 1');
        saveDetailsResult = await conn.query(
          'insert into data.details(product,videoLink,image) '
          'values( @product,@video,@image)',
          substitutionValues: {
            'product': productName,
            'video': videoLink,
            'image': imageData,
          },
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        print('here 2');
        dataSavedFuture =
            (saveDetailsResult!.affectedRowCount > 0 ? 'save' : 'not');
        print('here 3');
      });
    } catch (exc) {
      dataSavedFuture = 'err';
      print('here 4');
      exc.toString();
    }
    print('data save $dataSavedFuture');
    dataSavedFuture;
  }

  //Query DB from media
  List? queriedMediaFuture;
  PostgreSQLResult? queryMediaResult;

  Future<List?>? queryMedia(String? productName) async {
    try {
      await connection!.open();
      await connection!.transaction((mediaConn) async {
        print('here 1');
        queryMediaResult = await mediaConn.query(
          'select videoLink,image from data.details where product = @product',
          substitutionValues: {
            'product': productName,
          },
          allowReuse: false,
          timeoutInSeconds: 30,
        );
        queriedMediaFuture = (queryMediaResult!.affectedRowCount > 0
        ? queryMediaResult!.first.toList()
            : []
        );
        print(' lenght is ${queriedMediaFuture!.length}');
        print('here 3');
      });
    } catch (exc) {
      queriedMediaFuture = null;
      print('here 4');
      exc.toString();
    }
    queriedMediaFuture;
  }
}
