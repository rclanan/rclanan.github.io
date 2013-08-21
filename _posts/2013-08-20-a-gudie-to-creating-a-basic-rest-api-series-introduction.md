---
layout: post
title: "A guide to creating a basic REST API - Series Introduction"
comments: true
tags: web API REST guide series
category: coding
summary: An introduction into a series of guides on creating a basic REST API in multiple languages
---

In this new series, I plan on creating a collection of guides that will demonstrate how to create the same basic REST API in different programming languages.

As some of you who know me may know, I am very passionate about programming. I love learning a new language and comparing it to languages that I have already picked up. I am not entirely sure why I like so many different languages and I cannot, in all seriousness, answer which is my favorite language suffices to say I am enamored with all aspects of programming in general.

Now with that being said, one of the best ways that I learn to pick up a new language, is to dive in and create something that I created before in a different language, sort of like the premise of creating the hello world application that most books start with, however I feel that approach is too simplistic of an example so I decided to create this series on creating a basic REST API. This will be more so for my own personal reference as are all the blog post that I write but maybe this can also become somewhat of a [Rosetta Stone](http://en.wikipedia.org/wiki/Rosetta_Stone) for someone else trying to pick up a new language as well.

The first guide that I will create will deal with languages that I already have experience with just to get me into the flow of creating the guides. The follow-up guides will be for languages that are new to me. If there are any requests for a particular guide then I will be happy to do those as well. Also, I welcome any comments in which the guides can be improved.

---

#### **Disclaimer: ** _I do not claim to be an expert on REST, APIs, or for that matter in all the languages that I am going to try and cover. As such, please do not regard these as best practices but rather a stepping stone on yours (and mine) path of learning._

---

With all of that out of the way, let&#39;s say we get on with the guide. In this introduction, I am just going to cover the basics questions.

1. What is an API?

2. Examples of a Web API

3. HTTP Methods and HTTP Status Codes

4. What is REST?

5. Examples of REST

### What is an API? ###

An API or **A**pplication **P**rogramming **I**nterface can be defined as a contract (or [interface]( http://www.merriam-webster.com/dictionary/interface)) in which other applications utilize to interact with your system. In doing so this provides externally exposed features into your rather closed environment.

For this simplistic categorization of APIs, we can think of them coming in two flavors, one being software APIs and the other being web APIs. The focus of this series will be REST APIs which is a type of Web APIs.

Software APIs typically are related to software libraries or frameworks and are generally geared more towards desktop or client/server type applications.

Web APIs on the other hand deal with HTTP (**H**yper**t**ext **T**ransfer **P**rotocol) methods and HTTP Status Codes. More on those later, but the methods are the actions which typically control the API and the status codes along with a  response message is the result of what the API passes back.

### Examples of a Web API ###

Many of the most popular websites have published public APIs these days. Not all of these examples are of REST APIs as well as the ones that do include REST API they also include other types of APIs like SOAP. Some examples of these popular APIs are:

1. [Google API](https://code.google.com/)

  - Allows you to integration with maps&#44; email&#44; Google+&#44; and more.

2. [Facebook API](https://developers.facebook.com/docs/reference/apis/)

  - Provides integrations like the ability to &#39;Like&#39; and share pages from your website.

3. [Twitter API](https://dev.twitter.com/)

  - With this integration you can automate sending tweets when different events occur as well as read tweets via the API

4. [Salesforce.com](http://www.salesforce.com/us/developer/docs/api/index.htm)

  - Allows you to access information about your contacts&#44; send messages&#44; among other things

5. [LinkedIn API](https://developer.linkedin.com/apis)

  - Allows you to perform searches&#44; share content&#44; etc.

6. [Github API](http://developer.github.com/v3/)

  - Provides the ability to create and search among Issues&#44; Gists&#44; Git Data&#44; People&#44; as well as a host of other features

### HTTP Methods and HTTP Status Codes ###

##### HTTP Methods #####

HTTP methods are defined in the [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html) put out by the [World Wide Web Consortium (W3C)](http://www.w3.org/). These HTTP methods are commonly referred to as _&quot;verbs&quot;_. Currently there are a total of eight different verbs that are defined by the HTTP/1.1 protocol. Below these verbs are defined as well as their typical usage.

1. OPTIONS

  - Used to request what options are available for the request/response

2. GET

  - Used to retrieve information about a resource

3. HEAD

  - Same as GET except only returns the header information

4. POST

  - Used for creating a new resource

5. PUT

  - Used for updating a resource

6. DELETE

  - Used for deleting a resource

7. TRACE

  - Used for tracing the request message

8. CONNECT

  - Used for proxies

In a typical REST API we usually only concern ourselves with GET, POST, PUT, DELETE, which form the basis of [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) (Create, Read, Update, and Delete). The most commonly used HTTP method that most people unknowingly utilize is the GET verb. Since GET is used as a way to retrieve information about a resource, which is what is used to load web pages into a browser. Have you ever filled out an online form? Then you have most likely used POST, though there are other options as well. Some browsers do not implement all the HTTP methods nor do they need to.

##### HTTP Status Codes #####

HTTP Status Codes are also defined in the [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10) put out by the W3C. There are numerous types of status codes so for further information please refer to [section ten of the RFC](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10). I will name a few that you are most likely to use the most, though they all have recommended use cases that are associated with them.

1. Successful Codes - 2xx

  - 200 - OK

    - Request has succeeded

  - 201 - Created

    - New resource has been created

  - 204 - No Content

    - Request has been accepted

2. Redirect Codes - 3xx

  - 304 - Not Modified

    - Indicates resource has not been modified since last requested

3. Client Error Codes - 4xx

  - 400 - Bad Request

    - Request could not be understood

  - 401 - Unauthorized

    - Missing or invalid authentication information

  - 403 - Forbidden

    - User is not authorized to perform the operation or resource is unavailable

  - 404 - Not Found

    - Requested resource was not found

  - 409 - Conflict

    - A resource conflict

4. Server Error Codes - 5xx

  - 500 - Internal Server Error

    - General catch-all for thrown exceptions

  - 503 - Service Unavailable

    - Service cannot be used at the time of the request

### What is REST? ###

REST stands for **Re**presentational **S**tate **T**ransfer. For the best understanding of the REST architecture, I would refer to man who came up with the idea, [Roy Thomas Fielding](http://www.ics.uci.edu/~fielding/). In his [dissertation](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)[^1],_Architectural Styles and the Design of Network-based Software Architectures_, details on REST can be found in [chapter 5](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm).

REST works on the basic principle of resources. A resource can be anything from a person, to a task, to a blog post. While, REST does not have an official standard that must be followed there are best practices and recommendations put forth in the dissertations and the RFC, amongst other places on the internet. I will not attempt to set for any of those in these guides as I am just trying to show the basic functionality of REST APIs in implemented in different languages. Even though there isn't a set standard there are six defined constraints that attempt to define what exactly makes a RESTful API.

The six constraints are:

1. Client-Server

  - This one deals with the separation of concern between the client and server. If the interface between the two remains unchanged then the client and/or server can be replaced and developed independently of each other.

2. Stateless

  - By definition, REST means statelessness; therefore the state is handle the request is embedded in the request itself.

3. Cache

  - This one basically states that a resource must be cacheable and define themselves as such to the client.

4. Uniform Interface

  - This one defines the interface between the client and server that allows the two to be decoupled from each other. Uniform Interface can be further described by four interface constraints:
    1. Identification of Resources
      - Resources are identified in requests using URIs
    2. Manipulation of Resources through Representations
      - Providing you have permission to, you should have enough information to modify or delete a resource once given the representation of the resource
    3. Self-descriptive messages
      - States that each request/response describes how to process each message
    4. Hypermedia as the engine of application state (HATEOAS)
      - HATEOAS states that the client should be able to interact with the service entirely through hypermedia. For example, if you had a REST API that dealt with tasks, you would end up seeing something like:

```xml

<?xml version="1.0"?>

<task>

    <task_number>12345</task_number>

    <name>Some Name Here</name>

    <link rel="update" href="/tasks/12345/update" />

    <link rel="complete" href="/tasks/12345/complete" />

    <link rel="archive" href="/tasks/12345/archive" />

    <link rel="delete" href="/tasks/12345/delete" />

</task>

```

5. Layered System

  - The system should be composed of hierarchical layers by constraining component behavior such that each component cannot interact with any layer beyond the immediate layer in which they are interacting with. So, the client would not be able to interact directly with the end server if there is a cache server in between them. The client would interact with the cache server which would in turn interact with the server.

6. Code-On-Demand (Optional)

  - Basically, this states that additional functionality can be distributed in the form of scripts through the API.

### Examples of REST ###

Continuing on with the task example provided below, we will look at a few examples. The remaining guides will also utilize the task example as well.

If we wanted to get a list of all task, we would utilize the GET HTTP method:

```

GET http://example.com/tasks HTTP/1.1

```

Say we wanted to create a new task, for that we would utilize the POST HTTP method:

```xml

POST http://example.com/tasks HTTP/1.1

<?xml version="1.0"?>

<task>

    <name>Some Name Here</name>

</task>

```

If there is a specific task that you would like to see, we would use GET like above and provide it with the task_number:

```xml

GET http://example.com/tasks/12345 HTTP/1.1

```

To update the name of the task that we just retrieve we would use the PUT verb and could do something like:

```xml

PUT http://example.com/tasks/12345 HTTP/1.1

<?xml version="1.0"?>

<task>

    <name>New Name Here</name>

</task>

```

And assuming we had permission to do so, we can delete it by, you guessed it, the DELETE method:

```xml

DELETE http://example.com/tasks/12345 HTTP/1.1

```

For further examples, follow along with the rest of the series and see how we go about implementing a basic REST API for tasks, and then take it a step further and see how do implement the same API across different languages.

### References: ###

[^1]: Fielding, Roy Thomas. _Architectural Styles and the Design of Network-based Software Architectures_. Doctoral dissertation, University of California, Irvine, 2000.
