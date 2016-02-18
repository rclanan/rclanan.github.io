When it comes to operating systems today, I am a bit agnostic. I  have a personal preference for using Linux whenever I can but to say that one is better than the other, I am not sure I can. I see pros and cons to all three of the mainstream operating systems; Mac OS X, Linux, and Windows. 

As proof to that testament, I run all three in my current home setup and have for years. I have my trusty Mac book pro which I love because it's extremely light weight and 'just works'. I have my [Debian][1] machine which I alternate distros on all the time. I tend to stick with [Debian][2] or [Arch][3] mostly though. I also have my Windows 10 beast running my primary box, mostly due to the business world that I work in but to not lie completely, somewhat due to the games that I get addicted to as well! 

So after that tangent, back to what this article is about. I wanted to document for myself and whomever else stumbles across this. I am starting a new .NET freelancing project and I prefer to do all of my development in virtual machines for a few reasons. The two most important ones are; I can create a VM per project so that all resources, tools, and configurations are stored separately so I don't have to worry about conflicts between projects and secondly I don't have to clutter my main environments with tools for one off projects. 

I created the initial [virtual machine][4] (VM) on my main Windows 10 machine since that is where I will be doing most of my development, but I also like to move around a lot and needed to have the project be portable.

Initially, I just pulled out my trusty flash drive and copied the entire virtual machine folder over to it, then plugged it into my Mac. Once I tired to start the VM, I ran into issues stating that the network configuration was not setup properly. I went to correct that issue only to have it complain that it couldn't save the configuration back out. 

Afterwards, I messaged a peer of mine, [Allen Buckley][5], to see if he had run into this before which he had but didn't recall what he had to do to fix it. 

I knew I could recreate the VM on my Mac but didn't want to use up another Windows license since I had already used one for the other VM. That got me thinking, what about just creating the virtual machine on the Mac, using the same settings from Windows, and then point it to the virtual hard drive that was created with the other virtual machine. That allowed me to boot into the previously created virtual machine. Once in the VM, I reinstalled the [Guest Extensions][6] so that they would be the correct ones for the current host. 

So far, I haven't had any issues running the VM on my Mac and it is still functioning on my Windows machine as well. The only thing I have to remember is any configuration changes, I will either need to recopy the virtual drive or just duplicate the change in both VMs. 

Oh, and for Allen, after words, he said, "Yup. Sounds like what I had to do. Glad it worked." He proceeded to then say, "Would make a great blog post. Could have used that a year ago". So the challenge was then made to create one while it was still fresh in my mind as to what the ultimate fix was. Thanks for the blog suggestion Allen!

If anyone has a better method of transferring the VM across multiple machines, I would love to hear about them. My [google-fu][7] failed me as I didn't have any luck finding references to this. My biggest concern is the project specific configuration needing to be duplicated. Code wise, well we all use version control systems these days! Right? 

Until next time...

[1]:	https://www.archlinux.org/
[2]:	https://www.debian.org/ "Debian"
[3]:	https://www.archlinux.org/ "Arch"
[4]:	https://en.wikipedia.org/wiki/Virtual_machine "Virtual Machine"
[5]:	http://allenbuckley.com/ "Allen Buckley"
[6]:	https://www.virtualbox.org/wiki/Downloads
[7]:	https://en.wiktionary.org/wiki/Google-fu