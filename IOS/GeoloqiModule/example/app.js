
// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
window.add(label);
window.open();

// TODO: write your module tests here
var geoloqimodule = require('ti.geoloqi');
Ti.API.info("module is => " + geoloqimodule);

label.text = 'Loading...';

geoloqimodule.setDebug(true);

var geoloqiSessionProxy1 =   geoloqimodule.createLQSession({
  apiKey:'826e6e7dde7bb94bbde435b21ee611b9',
  apiSecret:'fc523705f1f57080b863f2815c5fe874'
});


//EVENTS
geoloqiSessionProxy1.addEventListener('onSuccess',function(e){
                               label.text =    'Done';
                               //alert("Request completed");
                               alert("Request completed With info " + e);
                               });

geoloqiSessionProxy1.addEventListener('onFailure',function(e){
                               label.text =    'Error!';
                               //alert("Request completed");
                               alert("[Error] " + e.error_description);
                               });  

geoloqiSessionProxy1.addEventListener('onValidate',function(e){
                                     label.text =    'Error!';
                                     //alert("Request completed");
                                     alert("[Validation Error] " + e.error_description);
                                     });    

geoloqiSessionProxy1.authenticateUser('t.sharma@globallogic.com','12344321');


var testButton   =   Titanium.UI.createButton({title:"Test Button",
                                                        top:200,
                                                        height: 30,
                                                        width: 100,
                                                        left:120
                                                        });
window.add(testButton);

testButton.addEventListener('click',function(){
                                      label.text =    'Loading...';
                             geoloqiSessionProxy1.runGetRequest('/account/profile'); 
                             
                           
                            //geoloqiSessionProxy.createAnonymousUserAccount({
                              //                                             phone:'999999',
                               //                                            address:'test123'
                           // });
                            
//                            geoloqiSessionProxy.createAccountWithUsernamePasswordAndExtraInfo('tarunsh_iphone',
//                                                                                              '12344321',
//                                                                                              {
//                                                                                              phone:'999999',
//                                                                                              address:'test123'
//                                                                                              }
//                                                                                              )
                                      });
var geoloqiSessionProxy2 =   geoloqimodule.createLQSession({
                                                           apiKey:'826e6e7dde7bb94bbde435b21ee611b9',
                                                           apiSecret:'fc523705f1f57080b863f2815c5fe874'
                                                           });


//EVENTS
geoloqiSessionProxy2.addEventListener('onSuccess',function(e){
                                      label.text =    'Done';
                                      //alert("Request completed");
                                      alert("Request completed With info " + e);
                                      });

geoloqiSessionProxy2.addEventListener('onFailure',function(e){
                                      label.text =    'Error!';
                                      //alert("Request completed");
                                      alert("[Error] " + e.error_description);
                                      });  

geoloqiSessionProxy2.addEventListener('onValidate',function(e){
                                      label.text =    'Error!';
                                      //alert("Request completed");
                                      alert("[Validation Error] " + e.error_description);
                                      });    

geoloqiSessionProxy2.authenticateUser('mohit.joshi@globallogic.com','Global@123');

var testButton1   =   Titanium.UI.createButton({
                                              title:"Make Request",
                                              top:250,
                                              height: 30,
                                              width: 100,
                                              left:120
                                              });
window.add(testButton1);

testButton1.addEventListener('click',function(){
                            label.text =    'Loading...';
                             geoloqiSessionProxy2.runGetRequest('/account/profile');
//                            geoloqiSessionProxy.runAPIRequest('/place/create',
//                                                              'POST',
//                                                              {
//                                                              latitude:'17.173141',
//                                                              longitude:'48.042111',
//                                                              radius   : '100',
//                                                              name     : 'Test Place',
//                                                              extra    :{cretedIn:'1600',cretedBy:'ShahJahan',inMemoryOf:'Mumtaj'}
//                                                              }); 

//                            geoloqiSessionProxy.runAPIRequest('/account/username',
//                                                              'GET',
//                                                              {}); 

                             
                           

//                             geoloqiSessionProxy.runPostRequestWithJSONArray('/link/create',[
//                                                                               {description:'http://www.tarun.kr.sharma@myMail.com'},
//                                                                               {description:'090909'},
//                                                                               {description:'1234'},
//                                                                               {description:'4444'}
//                                                                              ]);
                             });



var testButton2   =   Titanium.UI.createButton({
                                               title:"Saved Session",
                                               top:300,
                                               height: 30,
                                               width: 100,
                                               left:120
                                               });
window.add(testButton2);

testButton2.addEventListener('click',function(){
                             //label.text =    'Loading...';
                             //geoloqiSessionProxy2.runGetRequest('/account/profile');
                             
//                             geoloqiSessionProxy2.setSavedSession(geoloqiSessionProxy1);
//                            
//                             geoloqiSessionProxy2.savedSession().runGetRequest('/account/profile');
                             
                             
                             var newProxyWithAccessToken    =   geoloqiSessionProxy2.sessionWithAccessToken(geoloqiSessionProxy1.getAccessToken());
                             
                             newProxyWithAccessToken.runGetRequest('/account/profile');
                             
                             });


Ti.API.info("module exampleProp is => " + geoloqimodule.exampleProp);
geoloqimodule.exampleProp = "This is a test value";

if (Ti.Platform.name == "android") {
	var proxy = geoloqimodule.createExample({
		message: "Creating an example Proxy",
		backgroundColor: "red",
		width: 100,
		height: 100,
		top: 100,
		left: 150
	});

	proxy.printMessage("Hello world!");
	proxy.message = "Hi world!.  It's me again.";
	proxy.printMessage("Hello world!");
	window.add(proxy);
}

/*
// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

// open a single window
var window = Ti.UI.createWindow({
                                backgroundColor:'white'
                                });

var geoloqi = require('ti.geoloqi');
geoloqi.setDebug(true);

var scrollViewer = Ti.UI.createScrollView({
                                          contentWidth: 'auto',
                                          contentHeight: 1000,
                                          width: 1024,
                                          //height: 400,
                                          backgroundColor: '#c5c5c5',
                                          showVerticalScrollIndicator:true,
                                          showHorizontalScrollIndicator:false,
                                          zIndex: 10
                                          });


// android specific
if (Ti.Platform.name == "android") {
    var extras = {
    EXTRA_SDK_ID: "b272bc7b3add8b4cb32a0c9b222ab6c4",
    EXTRA_SDK_SECRET: "db9181529c7922e6d23764c4614966b4",
    EXTRA_USERNAME: "sapan.varshney@globallogic.com",
    EXTRA_PASSWORD: "S@pan123"
    }
    geoloqi.startLQService("ACTION_AUTH_USER",extras);
}



var buttonrestoreSavedSession=Ti.UI.createButton({
                                                 title:'Restore Saved Session',
                                                 top:5,
                                                 height:30,
                                                 width:200
                                                 });


var buttonIsPushEnabled=Ti.UI.createButton({
                                           title:'Is Push Enabled',
                                           top:60,
                                           height:30,
                                           width:200
                                           });

var buttonSetPushEnabled=Ti.UI.createButton({
                                            title:'Set Push Enabled',
                                            top:120,
                                            height:30,
                                            width:200
                                            });

var buttonGetUserName=Ti.UI.createButton({
                                         title:'Get UserName',
                                         top:180,
                                         height:30,
                                         width:200
                                         });

var buttonIsAnonymus=Ti.UI.createButton({
                                        title:'Is Anonymus',
                                        top:240,
                                        height:30,
                                        width:200
                                        });

var buttonCreateAccountWithAnonymusUser=Ti.UI.createButton({
                                                           title:'Create Acct With Anonymus User',
                                                           top:300,
                                                           height:30,
                                                           width:200
                                                           });

var buttonCreateAccountWithUserName=Ti.UI.createButton({
                                                       title:'Create Account With User Name',
                                                       top:360,
                                                       height:30,
                                                       width:200
                                                       });

var buttonAuthenticateUser=Ti.UI.createButton({
                                              title:'Authenticate User',
                                              top:420,
                                              height:30,
                                              width:200
                                              });

var buttonregisterDeviceToken=Ti.UI.createButton({
                                                 title:'Register Device User',
                                                 top:480,
                                                 height:30,
                                                 width:200
                                                 });

var buttonRunGetrequest=Ti.UI.createButton({
                                           title:'Run Get Request',
                                           top:540,
                                           height:30,
                                           width:200
                                           });

var buttonrunPostRequestWithJSONObject=Ti.UI.createButton({
                                                          title:'Run Post Request With JSON Object',
                                                          top:600,
                                                          height:30,
                                                          width:200
                                                          });

var runPostRequestWithJSONArray=Ti.UI.createButton({
                                                   title:'Run Post Request With JSON Array',
                                                   top:660,
                                                   height:30,
                                                   width:200
                                                   });

var runAPI=Ti.UI.createButton({
                              title:'Run API',
                              top:720,
                              height:30,
                              width:200
                              });

var buttonformatTimeStamp=Ti.UI.createButton({
                                             title:'Format Time Stamp',
                                             top:780,
                                             height:30,
                                             width:200
                                             });

var sessionProxy=geoloqi.createLQSession({
                                         apiKey:"b272bc7b3add8b4cb32a0c9b222ab6c4",
                                         apiSecret: "db9181529c7922e6d23764c4614966b4"
                                         });

sessionProxy.addEventListener('onSuccess',function(e){
                                      label.text =    'Done';
                                      //alert("Request completed");
                                      alert("Request completed With info " + e);
                                      });

sessionProxy.addEventListener('onFailure',function(e){
                                      label.text =    'Error!';
                                      //alert("Request completed");
                                      alert("[Error] " + e.error_description);
                                      });  

sessionProxy.addEventListener('onValidate',function(e){
                                      label.text =    'Error!';
                                      //alert("Request completed");
                                      alert("[Validation Error] " + e.error_description);
                                      });   


buttonrestoreSavedSession.addEventListener('click',function(){
                                           //var result=sessionProxy.restoreSavedSession();
                                           alert('Not available on iphone');
                                           });

buttonIsPushEnabled.addEventListener('click',function(){
                                     var result=sessionProxy.isPushEnabled();
                                     alert(result);
                                     });

buttonSetPushEnabled.addEventListener('click',function(){
                                      var result=sessionProxy.setPushEnabled(true);
                                      alert(result);
                                      });

buttonGetUserName.addEventListener('click',function(){
                                   //var result=sessionProxy.getUSerName();
                                   alert('Not available on iphone');
                                   });

buttonIsAnonymus.addEventListener('click',function(){
                                  //var result=sessionProxy.isAnonymous();
                                  alert('Not available on iphone');
                                  });

buttonCreateAccountWithAnonymusUser.addEventListener('click',function(){
                                                     sessionProxy.createAnonymousUserAccount();
                                                     });

buttonCreateAccountWithUserName.addEventListener('click',function(){
                                                 sessionProxy.createAccountWithUsername('pritisrivastava','sapan.varshney@gmail.com');
                                                 });

buttonAuthenticateUser.addEventListener('click',function(){
                                        sessionProxy.authenticateUser('sapan.varshney@globallogic.com','S@pan123');
                                        });


buttonregisterDeviceToken.addEventListener('click',function(){
                                           sessionProxy.registerDeviceToken('1234');
                                           });

buttonRunGetrequest.addEventListener('click',function(){
                                     var result=sessionProxy.runGetRequest("account/profile");
                                     });

buttonrunPostRequestWithJSONObject.addEventListener('click',function(){
                                                    var postJSON = {text:'This is test geonote'};
                                                    sessionProxy.runPostRequestWithJSONObject("geonote/create",postJSON);
                                                    });
runPostRequestWithJSONArray.addEventListener('click',function(){
                                             var jsonObjectArray=[{
                                                                  "date": "2010-07-23T09:19:38-07:00",
                                                                  "location": {
                                                                  "position": {
                                                                  "latitude": "45.445793867111",
                                                                  "longitude": "-122.64261245728",
                                                                  "speed": "10",
                                                                  "altitude": "0",
                                                                  "horizontal_accuracy": "24",
                                                                  "vertical_accuracy": "0"
                                                                  },
                                                                  "type": "point"
                                                                  },
                                                                  "raw": {
                                                                  "distance_filter": 5,
                                                                  "tracking_limit": 2,
                                                                  "rate_limit": 60,
                                                                  "battery": 86
                                                                  },
                                                                  "client": {
                                                                  "name": "Geoloqi",
                                                                  "version": "0.1",
                                                                  "platform": "iPhone OS 4",
                                                                  "hardware": "iPhone2,1"
                                                                  }
                                                                  }];
                                             sessionProxy.runPostRequestWithJSONArray("location/update",jsonObjectArray);
                                             });


runAPI.addEventListener('click',function(){
                        //var myJSON = {};
                        //sessionProxy.runAPIRequest("account/profile","GET",myJSON);
                        var postJSON = {"name" : "sapanvarshney3"};
                        sessionProxy.runAPIRequest("account/profile","POST",postJSON);
                        });
buttonformatTimeStamp.addEventListener('click',function(){
                                       //var result=sessionProxy.formatTimeStamp('1111111111');
                                        alert('Not available on iphone');
                                       });



window.add(scrollViewer);
scrollViewer.add(buttonrestoreSavedSession);
scrollViewer.add(buttonIsPushEnabled);
scrollViewer.add(buttonSetPushEnabled);
scrollViewer.add(buttonGetUserName);
scrollViewer.add(buttonIsAnonymus);
scrollViewer.add(buttonCreateAccountWithAnonymusUser);
scrollViewer.add(buttonCreateAccountWithUserName);
scrollViewer.add(buttonAuthenticateUser);
scrollViewer.add(buttonregisterDeviceToken);
scrollViewer.add(buttonRunGetrequest);
scrollViewer.add(buttonrunPostRequestWithJSONObject);
scrollViewer.add(runPostRequestWithJSONArray);
scrollViewer.add(runAPI);
scrollViewer.add(buttonformatTimeStamp);

//window.add(button);

//var location = geoloqi.createLQLocation({
// location: {"provider":{"name":"gps"}}//,"coords":{"longitude":77,"latitude":28,"speed":0,"accuracy":0,"altitude":0}}
//});
//
//alert("getSystemBatteryLevel: "+location.getSystemBatteryLevel());
//
//location.setBattery("90");
//
//alert("getBattery: "+location.getBattery());
//
//alert("toJson: "+location.toJson());

window.open();

*/