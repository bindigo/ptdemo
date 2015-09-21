var server = require("./server");
var ds = server.dataSources.mongodb;
var ptTables = ['PtUser', 'AccessToken', 'ACL', 'RoleMapping', 'Role'];

ds.automigrate(ptTables, function(err){
  if(err) throw err;

  console.log('PtDemo tables [' + ptTables + '] created in ', ds.adapter.name);
  ds.disconnect();
});
