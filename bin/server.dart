import 'package:force/force_serverside.dart';
import 'package:forcemvc/force_mvc.dart';
import 'package:mustache4dart/mustache4dart.dart';
import 'package:appengine/appengine.dart';

main() {
  ForceServer forceServer = new ForceServer();
  
  
  runAppEngine(forceServer.requestHandler).then((_) {
    // Server running. and you can do all the stuff you want!

     // Setup logger
     forceServer.setupConsoleLog();

     // we need to change {{ into [[ because of angular
     if (forceServer.server.viewRender is MustacheRender) {
         MustacheRender mustacheRender = forceServer.server.viewRender;
         mustacheRender.delimiter = new Delimiter('[[', ']]');
     }
 
     // Tell Force what the start page is!
     forceServer.server.use("/", (req, model) => "appengine");
    
     forceServer.on("add", (vme, sender) {
               forceServer.send("update", vme.json);
           });
  });
}