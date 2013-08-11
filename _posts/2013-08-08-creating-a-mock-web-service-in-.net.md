---
layout: post
title: "Creating a Mock Web Service in .NET"
comments: true
tags: .net mock web service howto
category: coding
summary: A brief walk through on how to create a mock web service in .net
---

Earlier this week at a client's I had to trace down where an exception was coming from when making a web service call. I had access to the client's front end code, the part that actually made the calls to the web service in question but didn't have access to the code for the web service. In order to replicate this, I figured the best route would be to create a mock web service that I could than throw exceptions or custom return values that I would like to test. 

Creating a mock web service has numerous benefits in terms of testing. Some of those might include: 

* By passing a web service that charges you for every service call.
* Serve up different scenarios for "expected" results.
* Simulate the web service being down or not available.   
* The service is still being developed and you need to continue on with your development.
* Test exceptions that might be thrown from the web service. 

With the later bullet point being my case, I start off by grabbing the [WSDL](http://en.wikipedia.org/wiki/Web_Services_Description_Language) file from the existing running web service. To do this you can just append ?wsdl to the path and it will generate the WSDL XML for you. Save this out to your local machine. 

After acquiring the WSDL XML, we will use the [wsdl.exe](http://msdn.microsoft.com/en-us/library/7h3ystb6.aspx) file provided by Visual Studio to create our service interface. Open up the [Visual Studio Command Prompt](http://msdn.microsoft.com/en-us/library/ms229859.aspx), and type:
```
wsdl /language:CS /namespace:Your.Namespace /out:Output\Directory /protocol:SOAP /serverinterface yourwsdlxmlfile.wsdl
```
This should create a .cs file in the /out directory that will contain the interface that you need to implement to create a mock web service. 

In Visual Studio, create a new ASP.NET Empty Web Application from the Web installed templates under Add New Project. Add the .cs file to that was generated to this project, and then add a new web service. 

In the code behind of this web service, change the class to implement the interface name of the .cs file that you just added to the project. Once that is done, tell Visual Studio to implement the interface which will give you stubs for the web service methods. Add the [WebMethod] attribute to each of the method calls to make them accessible via the web service. From here you can either leave the default throw in place or add your own custom code that you want your mock service to implement. 

If you run the application you should be able to navigate to your mock web service. If that is successful, then you can go to your existing client code and add a web service to the generated URL that points to the newly created mock web service. 

Have fun testing your web service! Just don't forget to point the web reference back to the original web service instead of your mock service before deploying. 

Until next time...
