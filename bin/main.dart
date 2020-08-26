import 'dart:async';
import 'package:args/args.dart';
import 'dart:io';

var parser;
var parsedResults;
var port;
HttpServer server; 

Future<String> analisaPedido(HttpRequest req) async {


  HttpResponse res;
  res = req.response;

  res.write('req.method [${req.method}]<br>');
  res.write('req.uri.path [${req.uri.path}]<br>');
  res.write('req.requestdUri [${req.requestedUri}]<br>');
  res.write('req.requestdUri.path [${req.requestedUri.path}]<br>');
  var lista = req.requestedUri.path.split('/');
  res.write((lista.length - 1).toString() + ' parâmetros da URL<br>');
  int i;
  for (i = 1; i < lista.length; i++) {
    res.write(lista[i].toString() + '<br>');
  }
  res.write('req.protocolVersion [${req.protocolVersion}]<br>');
  res.write('req.session [${req.session}]<br>');
  res.write('req.connectionInfo.hashcode [${req.connectionInfo.hashCode}]<br>');
  res.write('req.connectionInfo.localport [${req.connectionInfo.localPort}]<br>');
  res.write('req.connectionInfo.remoteAddess [${req.connectionInfo.remoteAddress}]<br>');
  res.write(
      'req.connectionInfo.remotePort [${req.connectionInfo.remotePort}]<br>');

  res.write(
      'req.connectionInfo.remoteAddress.address [${req.connectionInfo.remoteAddress.address}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.type [${req.connectionInfo.remoteAddress.type}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.isLinkLocal [${req.connectionInfo.remoteAddress.isLinkLocal}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.isMulticast [${req.connectionInfo.remoteAddress.isMulticast}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.isLoopback [${req.connectionInfo.remoteAddress.isLoopback}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.host [${req.connectionInfo.remoteAddress.host}]<br>');
  res.write(
      'req.connectionInfo.remoteAddress.rawAddress [${req.connectionInfo.remoteAddress.rawAddress}]<br>');

  res.write('req.method [${req.method}]');
  return '<br>OK FINAL';
 }
  
void main(List<String> arguments) async {
  parser = ArgParser()..addOption('port', defaultsTo: '8080');
  parsedResults = parser.parse(arguments);
  port = int.tryParse(parsedResults['port']);
  

  await HttpServer.bind(InternetAddress.loopbackIPv4, port).then((server) async {
    print('Servindo em ${server.address}:${server.port}');
    server.listen((HttpRequest request) async {
      if (request.requestedUri.path.contains('CbPjDrPcB')) {
        print('recebido [${request.requestedUri.path}] [${request.headers['x-real-ip'].first}] ['+ DateTime.now().toString() +']');
      }
      await request.response
        ..headers.contentType =
            ContentType('text', 'html',  charset: 'utf-8')
        ..write(await analisaPedido(request));
      await request.response.close();

        
    });
  });
}

