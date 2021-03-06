# Autopsy-macOS-Install
Automated Autopsy Installer For macOS

I developed this script to automate some of the tasks and configuration required to launch Autopsy GUI on a Mac.
I developed this script primarily for other students on my university course - but could possibly help others too, I hope!

Demonstration Video - https://youtu.be/RlbWaIJs4cY

--------------------
This installer script will install the following prerequesites prior to installing Autopsy / Sleuthkit
--------------------
 -	Brew Package Manager - Allows for, well, packages to be installed :-)
 -	Java Development Kit (JDK) - Allows for the compilation of Sleuthkit
      		-'ant'
      		-'libewf'
      		-'afflib' - forensic friendly 'storage' support :)!
      		-'libpq'
 -	wget - could have used curl...wget is ever so slightly easier! used to fetch remote files
--------------------
Other System Changes/Modifications
--------------------
 -	JAVA_HOME Variable Created - No need to manually set Java location
 -	Compiles/'Installs' Sleuthkit - Prerequesite for Autopsy to run
--------------------
--------------------
Launch Instructions
--------------------
You can either launch with '-agree' to allow the installer script to execute fully, or...
Launch with '-start' to skip installation and start Autopsy, if it's already present on the Mac (following the execution of the installer you can simply re-execute this)

Be sure to start this script from the same location every time :-)

Hope you enjoy! Feel free to create a pull request!

-James
