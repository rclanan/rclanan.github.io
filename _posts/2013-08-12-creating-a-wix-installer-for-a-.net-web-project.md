---
layout: post
title: "Creating a WiX installer for a .NET Web Project"
comments: true
tags: .net WiX web project installer howto
category: coding
summary: A brief walk through on how to create a WiX installer for a .NET web project
---

The other day I was wrapping up some changes to a production web service at a clients, got ready to fill out the deployment instructions when I noticed that there was no installer package or previous deployment plan in place and this was a service that had been in production for quite some time now. The client has since started using WiX for all of their deployment packages.

With that being said, I figured I would share the steps I used to create the WiX installer for this web service I was getting ready to deploy.

First create a new WiX project in the solution where the web project is.

![Add New Project][id_1]

I like to contain all my "settings" in an include file for easier maintenance. To do so the next step I do is to create an include file called Configuration.wxi.

![Add New Item][id_2]

Some of the basic elements I define in the configuration include file are:

* Product Name - Name of the product you are installing
* Product Title - Title of the product you are installing
* Manufacturer - Your company name
* App URL - URL to point to more information about the application or the application itself
* Description - Brief overview of what the application is for
* Comments - Additional note about the application
* Install Version - Version of the product. This can be auto incremented with the use of certain build scripts but for this client they controlled this setting manually.
* Upgrade Code - Product GUID used for tracking upgrades

So you will end up with something that looks along the lines of this:

```xml
<?xml version=" 1.0" encoding=" utf-8"?>
  <Include>
    <? define ProductName="Business Web Service" ?>
    <? define ProductTitle="Business Web Service" ?>
    <? define Manufacturer="Business Name, Inc." ?>
    <? define AppURL="http://www.businessname.com" ?>
    <? define Description="Installer for Business Web Service" ?>
    <? define Comments="Business Web Service Installer" ?>
    <? define InstallVersion="1.0.0.0 ?>
    <? define UpgradeCode="YOUR-GUID-HERE" ?>
</Include>
```

Next thing we need to do is update our references. We will want to add two references.

1. The project
     * Change Harvest to False
     * Change Project Output Groups to None
2. WiXUIExtension

Now we need to edit the WiX installer project file. At the top of the project file we need to enable project havesting. To the top of the file in the PropertyGroup element add: 

```xml
<?xml version=" 1.0" encoding=" utf-8"?>
<Project ToolsVersion=" 4.0" DefaultTargets=" Build" xmlns=" http://schemas.microsoft.com/developer/msbuild/2003 ">
  <PropertyGroup>
    < EnableProjectHarvesting>True </EnableProjectHarvesting>
```

Under the ItemGroup that references your projects solution we need to add a tag to let WiX know that this is a web project. This will be used for conditional statements later on:

```xml
<ItemGroup>
    < ProjectReference Include ="..\BusinessWebService\BusinessWebService.csproj ">
      < Name>BusinessWebService </Name>
      < Project>{PROJECT-GUID-HERE} </Project>
      < Private>True </Private>
      < DoNotHarvest>True </DoNotHarvest>
      < RefProjectOutputGroups>
      </ RefProjectOutputGroups>
      < RefTargetDir>INSTALLFOLDER </RefTargetDir>
      < WebProject>True </WebProject>
    </ ProjectReference>
</ItemGroup>
```

Next we need to add a custom target that will get trigger before the build. To do so at the end of the file add: 

```xml
      <Target Name=" BeforeBuild">
      </Target>
</Project>
```

We need to define four elements in this target. For more detailed information on these elements visit the wix documentation.

* MSBuild - Sets up the conditional to look for the WebProject condition that we setup previously
* PropertyGroup - Used to define a constant that points to the PackageDir
* ItemGroup - Used to specify the input paths for the linker
* HeatDirectory - Controls the collection of files needed to be included in this web project. Heat is a time saver as otherwise you would have to specify all of your files manually.

For my project, I ended up with something that looks like this:

```xml
<Target Name=" BeforeBuild">
    < MSBuild Projects ="%(ProjectReference.FullPath) "
             Targets=" Package"
             Properties=" Configuration=$(Configuration);Platform=AnyCPU "
             Condition=" '%(ProjectReference.WebProject)'=='True'" />
    < PropertyGroup>
      < DefineConstants Condition ="'%(ProjectReference.WebProject)'=='True' ">
        %(ProjectReference.Name).PackageDir=%(ProjectReference.RootDir)%(ProjectReference.Directory)obj\$(Configuration)\Package\PackageTmp\
      </ DefineConstants>
    </ PropertyGroup>
    < ItemGroup>
      < LinkerBindInputPaths Include=" %(ProjectReference.RootDir)%(ProjectReference.Directory)obj\$(Configuration)\Package\PackageTmp\ " />
    </ ItemGroup>
    < HeatDirectory OutputFile ="%(ProjectReference.Filename).wxs "
                   Directory=" %(ProjectReference.RootDir)%(ProjectReference.Directory)obj\$(Configuration)\Package\PackageTmp\ "
                   DirectoryRefId=" INSTALLLOCATION"
                   ComponentGroupName=" %(ProjectReference.Filename)_Project"
                   AutoGenerateGuids=" false"
                   GenerateGuidsNow=" true"
                   SuppressCom=" true"
                   SuppressFragments=" true"
                   SuppressRegistry=" true"
                   SuppressRootDirectory=" true"
                   ToolPath=" $(WiXToolPath)"
                   Condition=" '%(ProjectReference.WebProject)'=='True'"
                   Transforms=" %(ProjectReference.Filename).xsl"
                   PreprocessorVariable=" var.%(ProjectReference.Name).PackageDir" />
  </Target>
```

Normally, you would want it to auto generate the GUIDs for you but that option can not be used if your installing to a non-standard directory location. Once the rest of the pieces are in place, we will get a new file in our projects directory that you will need to manually include to your projects source tree once we build it for the first time.

Next I need to add an XSL file to our project that will control the omitting of certain files that I don't want to include in the file installer. For this project, since the client doesn't want to push out xml or config files. I will omit them from the installer using an Xsl Stylesheet defined in the Transorms property earlier in the Target element of the project file.

![Add New Item][id_3]

This file will look like:

```xml
<?xml version=" 1.0" encoding=" utf-8"?>

<xsl:stylesheet version=" 1.0" xmlns:xsl=" http://www.w3.org/1999/XSL/Transform"
                xmlns:wix=" http://schemas.microsoft.com/wix/2006/wi"
                xmlns:msxsl=" urn:schemas-microsoft-com:xslt" exclude-result-prefixes=" msxsl">

  <xsl:output method=" xml" indent=" yes" />

  <!--Identity Transform-->
  <xsl:template match=" @*|node()">
    < xsl:copy>
      < xsl:apply-templates select ="@*|node() " />
    </ xsl:copy>
  </xsl:template>

  <!--Set up keys for ignoring various file types-->
  <xsl:key name=" config-search"
           match=" wix:Component[contains(wix:File/@Source, '.config') and not(contains(wix:File/@Source, '.production'))]"
           use=" @Id" />
  <xsl:key name=" wixlib-search" match=" wix:Component[contains(wix:File/@Source, '.wixlib')]" use ="@Id " />
  <xsl:key name=" svn-search" match=" wix:Component[ancestor::wix:Directory/@Name = '.svn']" use ="@Id " />
  <xsl:key name=" xml-search" match=" wix:Component[contains(wix:File/@Source, '.xml')]" use ="@Id " />

  <!--Match and ignore .config files-->
  <xsl:template match=" wix:Component[key('config-search', @Id)]" />
  <xsl:template match=" wix:ComponentRef[key('config-search', @Id)] " />

  <!--Match and ignore leftover .wixlib files on developer machines -->
  <xsl:template match=" wix:Component[key('wixlib-search', @Id)]" />
  <xsl:template match=" wix:ComponentRef[key('wixlib-search', @Id)] " />

  <!--Match and ignore “.svn" directories on build machines -->
  <xsl:template match=" wix:Directory[@Name = '.svn']" />
  <xsl:template match=" wix:ComponentRef[key('svn-search', @Id)]" />

  <!--Match and ignore leftover .xml files on developer machines -->
  <xsl:template match=" wix:Component[key('xml-search', @Id)]" />
  <xsl:template match=" wix:ComponentRef[key('xml-search', @Id)]" />

</xsl:stylesheet>
```

Now we can move to our final file which should be named Product.wxs. This file is the key to controlling all aspects of the installer. The first thing we need to include is our include file. We will do so using the <?include ?> directive.

```xml
<?xml version=" 1.0" encoding=" UTF-8"?>
<WiX xmlns=" http://schemas.microsoft.com/wix/2006/wi">
  <?include Configuration.wxi ?>
```

With our configuration file included, we will now have access to all of the variables that we defined earlier in the form of $(var.VariableName). Let's configure the Product element next.

```xml
<Product Id=" *"
           Name=" $(var.ProductName)"
           Language=" 1033"
           Version=" $(var.InstallVersion)"
           Manufacturer=" $(var.Manufacturer)"
           UpgradeCode=" $(var.UpgradeCode)">
```

Next we will move onto the Package element:

```xml
<Package Id=" *"
             Description=" $(var.Description)"
             Comments=" $(var.Comments)"
             Manufacturer=" $(var.Manufacturer)"
             InstallerVersion=" 200"
             Languages=" 1033"
             Compressed=" yes"
             SummaryCodepage=" 1252" />
```

From there we can go on to configure our Feature element:

```xml
<Feature Id=" ProductFeature" Title=" $(var.ProductTitle)" Level=" 1">
      < ComponentGroupRef Id ="BusinessWebService_Project " />
      < ComponentGroupRef Id ="Product.Generated " />          
</ Feature>
```

The default Product file comes with a Fragment whose Id is called ProductComponents. We can remove that since we will be using Heat to create that fragment. Otherwise we would have to specify each of our files in that fragment manually.

Now we need to configure the InstallLocation to point to where we want to program to be installed initially.

```xml
< Directory Id =" TARGETDIR " Name =" SourceDir ">
      < Directory Id = "PROGRAMFILES " Name = "Program Files " >
        < Directory Id = "INSTALLLOCATION " Name = "BusinessWebService " />
      </ Directory >
</ Directory >
```

We also need to declare a property that will tell WiX where the installlocation is:

```xml
<Property Id=" WIXUI_INSTALLDIR" Value=" INSTALLLOCATION" />
```

After that you should be ready to build your installer. Upon a successful build you will need to include the file that was generated in the project's folder. You will end up with a structure like:

![Add New Item][id_4]

Until next time...

### References: ###

* C Surfleet. (2011, June 30). Simplify Deployment with Visual Studio and WiX [Web log post]. Retrieved from [http://www.chrissurfleet.co.uk/post/simplify-deployment-with-visual-studio-and-wix.aspx](http://www.chrissurfleet.co.uk/post/simplify-deployment-with-visual-studio-and-wix.aspx)

[id_1]: http://farm8.staticflickr.com/7326/9472180915_ef89a463d3.jpg
[id_2]: http://farm3.staticflickr.com/2853/9474968680_48cb47c7d1.jpg
[id_3]: http://farm3.staticflickr.com/2840/9472180923_756dc0b1a7.jpg
[id_4]: http://farm4.staticflickr.com/3825/9474968650_c528df53ff_s.jpg 
