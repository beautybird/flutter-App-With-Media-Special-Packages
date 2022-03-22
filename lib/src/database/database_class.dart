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
        dataSavedFuture =
            (saveDetailsResult!.affectedRowCount > 0 ? 'save' : 'not');
      });
    } catch (exc) {
      dataSavedFuture = 'err';
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
        queryMediaResult = await mediaConn.query(
          'select videoLink,image from data.details where product= @product order by id',
          substitutionValues: {
            'product': productName,
          },
          allowReuse: false,
          timeoutInSeconds: 30,
        );

        queriedMediaFuture = (queryMediaResult!.affectedRowCount > 0
            ? queryMediaResult!.first
            : []);
      });
    } catch (exc) {
      queriedMediaFuture = null;
      exc.toString();
    }
    return queriedMediaFuture;
  }
}
