#!/bin/bash


if [ $# -eq 0 ]
then
	echo -e "autopsy-installer.sh - DuffyAPP_IT - @J_Duffy01\nUsage: ./autopsy-installer.sh -agree"
    echo -e "----------\nPre-Installation Notice\n----------"
    echo -e "--------------------\nThis installer script will install the following prerequesites prior to installing Autopsy / Sleuthkit\n--------------------"
    echo -e " -\tBrew Package Manager - Allows for, well, packages to be installed :-)"
    echo -e " -\tJava Development Kit (JDK) - Allows for the compilation of Sleuthkit"
    echo -e "      \t\t-'ant'"
    echo -e "      \t\t-'libewf'"
    echo -e "      \t\t-'afflib' - forensic friendly 'storage' support :)!"
    echo -e "      \t\t-'libpq'"
    echo -e " -\twget - could have used curl...wget is ever so slightly easier! used to fetch remote files"
    echo -e "--------------------\nOther System Changes/Modifications\n--------------------"
    echo -e " -\tJAVA_HOME Variable Created - No need to manually set Java location"
    echo -e " -\tCompiles/'Installs' Sleuthkit - Prerequesite for Autopsy to run"
    echo -e "--------------------"


    # https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.10.1/sleuthkit-4.10.1.tar.gz
	exit 1
fi


if [[ $1 = "-start" ]]
then
    echo -e "---------------------------------------------------------\nautopsy-installer.sh - DuffyAPP_IT - @J_Duffy01\n---------------------------------------------------------"
    echo "Launching!"
    cd autopsy-4.17.0
    bin/autopsy --jdkhome /usr/local/opt/openjdk
fi

if [[ $1 = "-agree" ]]
	then
    echo -e "---------------------------------------------------------\nautopsy-installer.sh - DuffyAPP_IT - @J_Duffy01\n---------------------------------------------------------"
    echo "Waiting For 5 Seconds (If You Do Not Wish To Install, Hit Control+C Now!)"
    echo -n "."
    sleep 1
    echo -n "."
    sleep 1
    echo -n "."
    sleep 1
    echo -n "."
    sleep 1
    echo -n "."
    sleep 1
    echo -n "!\n"
    sleep 1


    rm -rf sleuth* 2>/dev/null
    # check if brew exists
    if which brew >/dev/null 2>/dev/null ; then
    echo "[+] Brew Exists"
    # continue install
    if brew tap bell-sw/liberica ; then
        if brew install --cask liberica-jdk8-full ; then
            echo "[+] Succesfully Installed Liberica JDK"
            # JDK Installed
            export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
            echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)' | tee >> ~/.bashrc >> ~/.zshrc
            echo "[+] Set JAVA_HOME Variable In bash&zsh configs!"

            echo "[+] Installing Sleuthkit Dependencies"
            brew install ant afflib libewf libpq wget
            echo "[+] Sleuthkit Dependencies Installed"
            echo "[+] Creating JDK Symlink"
            rm /usr/local/opt/openjdk
            ln -s $JAVA_HOME /usr/local/opt/openjdk
            echo "[+] Downloading Sleuthkit"
            if wget https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.10.1/sleuthkit-4.10.1.tar.gz ; then
                echo "[+] Download Complete - Extracting..."
                tar xvf sleuthkit*
                cd sleuthkit-4.10.1
                export CPPFLAGS="-I/usr/local/opt/libpq/include"
                echo "[+] Preparing To Compile..."
                if ./configure ; then
                    echo "[+] Ready To Compile"
                    if make ; then
                        echo "[+] Compiled - Installing..."
                        if sudo make install ; then
                            echo "[+] Installed"
                            echo "[+] Installing Testdisk"
                            if brew install testdisk ; then
                                echo "[+] Testdisk Installed"
                                wget https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.17.0/autopsy-4.17.0.zip
                                unzip autopsy-4.17.0.zip
                                cd autopsy-4.17.0
                                sh unix_setup.sh
                                echo "[+] Launching..."
                                bin/autopsy --jdkhome /usr/local/opt/openjdk
                            else
                                echo "[!] Installation Failed"
                            fi

                        else
                            echo "[!] Failed"
                        fi

                    else
                        echo "[!] Failed To Compile"
                    fi
                else
                    echo "[!] Failed To Compile"
                fi
            else
                echo "[!] Failed To Download Sleuthkit"
            fi


        else
            echo "[!] Failed To Install Liberica JDK"
        fi
    else
        echo "[!] Error executing 'brew tap bell-sw/liberica'"
    fi
    



    else
        echo "Installing Brew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Please re-run this script to install further pre-requesites."
    fi

fi