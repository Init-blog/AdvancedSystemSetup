### The perfect setup a developer really needs - from a developer

I've been an avid Medium reader for years now, drawn to articles on new technologies and their potential to solve the daily challenges I face as a developer. Yet, it often feels like every three days, someone publishes a new piece about their elaborate development setup, packed with an array of software, utilities, and tools. After sifting through countless such articles, I'm left perplexed—why do people rely on such an abundance of tools? How does yet another Mac clone, an alternative spotlight prompt, or a VSCode extension, which adds to the endless list of to-do apps junior developers create as their first projects, enhance my daily coding experience?

I've come to believe that less is more when it comes to installations. After discovering that a colleague had installed an ,' [NPM dependency called 'is-odd](https://medium.com/@areyou/are-you-kidding-me-cf7bbb348ed0) which could easily be replaced with a one-liner, my skepticism towards unnecessary installations grew even more.

That said, minimalism shouldn't equate to coding on sand with a stick. I've managed to create a streamlined setup and a minimalistic approach to ensure consistency, repeatability, and a one-step installation process. 

Let me demonstrate what I mean by that.

#### Up-to-date check:

```
Article published in November 2023. 

Compatibility was tested on:
macOS Sonoma 14.1

Software requirements:
Any terminal/console app running some ZSH shell
```

Not sure if you are using ZSH? Read this article on how to [Check and configure your shell for ZSH](wa)

#### Do i really need a rubber dock extension for VSCode?

You definetly need, when your next Zoom meeting rolls around and it's time to share your screen, you've got to look like a pro developer. Make sure to have a Rubik's Cube and a Rick and Morty mug filled with yerba mate from the gauchos in Argentina on your table. And hey, stash that mouse away, let your mom have it; we're all about that VIM life here.

Jokes aside, what really matters to me as a developer is keeping RAM usage low, keeping cache folders in check, making the most of debugging tools, and avoiding the headache of dealing with system or environment configuration files as much as humanly possible. I delve into that configuration rabbit hole once, not every time I start a new project.

For my next trick, ill show you what i really can't live without, even if (god forbids) chat GPT goes down, i will still be able to code as ive been doing for all those dark ages in which stack overflow was your only way out.

#### First of all

Before I dive into my trusty toolbox, let me illustrate just how hard a lazy man works to remain idle.

I don't go about this by painstakingly installing each item one by one from a checklist. Instead, I craft a single command that installs and sets up everything I need. Whenever I stumble upon a new tool that stands the test of time, I seamlessly integrate it into my script and keep on rolling. I can't afford to overlook any obscure configuration files crucial for my setup to run smoothly, so here it is:

```shell
# This is what my current setup script looks like:
# Notice: This command will install all the software and configurations described in this article
(REPO_OWNER="Init-blog"; REPO_NAME="AdvancedSystemSetup"; curl -sSL https://raw.githubusercontent.com/"$REPO_OWNER"/"$REPO_NAME"/main/install.sh | sh -s "$REPO_OWNER" "$REPO_NAME")
```
Curious about the workings of this intriguing process? Check out my article delving into the [inner workings of this setup script](https://medium.com/initdev/automate-your-entire-mac-development-setup-with-a-one-line-command-5eca90fd63ab). 

This script, highlighted in the article, serves primarily for testing purposes. For the actual, comprehensive version inclusive of my personal toolkit, I suggest cloning it from the repository: 
https://github.com/Init-blog/AdvancedSystemSetup 
Customize it to your liking, and execute it from your own public repository like this:
```shell
# Dont forget to replace the YOUR_GIT_USERNAME and OUR_REPO_NAME strings with your own!
(REPO_OWNER="YOUR_GIT_USERNAME"; REPO_NAME="YOUR_REPO_NAME"; curl -sSL https://raw.githubusercontent.com/"$REPO_OWNER"/"$REPO_NAME"/main/install.sh | sh -s "$REPO_OWNER" "$REPO_NAME")
```

*Im joking, never ever do such a senseless thing.*

This is what my current setup script looks like:

That's it. I wipe the computer, log back in, and paste it directly into the default terminal. No other dependencies required. Voila!
Now, let's break down what this command is doing to your computer and how you can customize it for your own needs.
This isn't a Linux boot camp, but for the sake of my sanity, let me explain what this command does. We want to ensure it won't steal your passwords and email them to me for blackmailing my readers. Always assume any command you find online will attempt to do just that.

```shell

curl # Here, we're using 'curl' to grab content from a specific URL. Think of it as the ultimate data transfer wizard for the command line.

-s # This flag is like the 'silent mode' of curl. It keeps the operation hush-hush, hiding any progress, confirmations or error messages. Perfect for those scripted tasks.

-S # If something goes wrong during the download, this flag ensures curl speaks up and tells you about it. No secrets here!

-L # Don't you just hate it when a file has moved or redirected? Well, with this little '-L' flag, curl automatically tracks it down, following any redirects

-sSL # Now you can simply blend all the above superpowers into one with this.

https://github.com/laikmosh/System-Setup/raw/main/install.sh # This is the link to the raw script file on GitHub. Our download source, if you will.

| # And now, the pipe operator, it exists to pass the output of the previous command to the next command, in this case the downloaded file from the curl command will be passed to the sh command.

sh # Finally, the trusty 'sh' command steps in to execute the shell script from the GitHub URL. Let the magic unfold!
```

Fine, everything looks good to me, run it and let it rain! But wait, what in the lords name is the install.sh going to do?
Lets take a look:

install.sh

```shell
#!/bin/bash

# Prompt for sudo password, as it will be required for the installation
echo 'Password required for installation:'
if ! sudo -v; then
    echo "Failed to obtain sudo privileges. Exiting."
    exit 1
fi

# Setup a temporary folder to download the repository, exit script if filesystem is not writable
mkdir -p "$HOME/SystemSetupTmp"
cd "$HOME/SystemSetupTmp" || exit

# Download and unzip repository, exit script if download fails
curl -L -o master.zip https://github.com/laikmosh/System-Setup/archive/refs/heads/main.zip
unzip -o master.zip
cd System-Setup-main || exit

# Install brew and brewfile
sh brew/install.sh

# System custom settings
sh SysSettings/setup.sh

# Finally, remove the temporary directory and its contents recursively
rm -rf "$HOME/SystemSetupTmp"
echo "Temporary files removed successfully."
```

So it seems all that this script does is fetch the repository from github, download and unzip it to a temporary folder, and then execute two scripts within the repo, **brew/install.sh** and <strong>SysSettings/setup.sh</strong>, finally it deletes everything it has downloaded.
First lets check what brew/install.sh has in for us:

brew/install.sh

```shell
#!/bin/bash

# Install Homebrew
echo "Installing Homebrew"/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" < /dev/null

# Enable the brew command
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install packages using the Brewfile
brew bundle --file=./brew/Brewfile

# Configure zsh autocomplete
# Create the .zshrc file if it doesn't exist
touch ~/.zshrc
# Append this line to the end of the ~/.zshrc file
echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
# Source the updated .zshrc file
source ~/.zshrc

# When installing any software from the internet
# Apple will warn you about it being unsafe teh first time you open it
# Add to the list below all the apps you want to declare as safe to skip the warnings
apps=(    
    "/Applications/Google Chrome.app"    
    # "/Applications/Visual Studio Code.app"
)

for app in "${apps[@]}"do    
    # Remove the com.apple.quarantine attribute    
    sudo xattr -dr com.apple.quarantine "$app"
done
```

It seems pretty self explanatory to me but of course i wrote it so it should make sense, in a nutshell it:

* installs and configures homebrew
* uses the brewfile in the repository to install all the software
* runs some configurations to enable the zsh autosuggetions for your terminal
* finally it tells your mac to trust some of the apps it has downloaded from the internet so it does not warn you about it when you open it.

So what comes in the brewfile? lets check

brew/Brewfile

```brewfile
# These pacakges provide the necessary information for Homebrew 
# to install and manage various software packages and applications.
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

# Homebrew can manage 3 kind of apps
# 'brew' will be used for CLI software
# 'mas' will be used for Mac App Store software
# 'cask' will be used for all the apps not available on the app store

# The brew command will fetch and execute installation instructions from homebrew
# those instructions are called formulae
# "mas" stands for MacAppStore, this package allows homebrew to install apps from the mac store
brew "mas"
# "zsh-autosuggestions" will enable terminal suggestions based on you command history
# this formulae requires the ~/.zshrc to be modified, this repo includes a script
# that will automatically set up this.
brew 'zsh-autosuggestions'

# Once "mas" is installed we can use that command to install apps from the app store
# For this example we are only installing "The Unarchiver", 
# which is a file compressor/decompressor, like a Mac winzip

mas "The Unarchiver", id: 425424353
# mas "Keynote", id: 409183694
# mas "Numbers", id: 409203825
# mas "Pages", id: 409201541

# I have commented the other apps, but feel free to uncomment them and add your own
# The "app name string" is used for identification, while 
# the id ensures the correct app is installed from the Mac App Store via Homebrew.
# You can find the app id by looking for your app on the AppStore, sharing as a link
# and in the link you'll find a number, that is the app id
# Example: https://apps.apple.com/mx/app/keynote/id409183694

# Most of the cool apps are not available from the AppStore
# For those we use the cask command
# For this example we'll only install Chrome
cask "google-chrome"
# cask "visual-studio-code"
# cask "microsoft-edge"
# cask "docker"
# cask "zoom"
# cask "miro"
# cask "figma"

# Uncomment all that you want or you could also search for 
# any app you want on https://brew.sh/ to get the cask id
```

This Brewfile is 95% comments but on the remaining 5% it instructs homebrew to:

* download the latest definitions for available apps
* install the package to allow App Store installations
* install the zsh autosuggestions package
* install "The Unarchiver" from the mac store
* install Google Chrome

SysSettings/setup.sh

```brewfile
#!/bin/bash

# Set default folder for storing screenshots
# Create the directory if it doesn't exist
mkdir -p ~/Downloads 
# Sets it as default location for screenshots
defaults write com.apple.screencapture location ~/Downloads

# Install fonts
# Copy fonts to the Fonts directory
cp -a ./fonts/. ~/Library/Fonts 
```

In this case it sets a configuration to change the default location of the screenshots from the default desktop to the downloads folder, i like it this way because the downloads folder is right there in the dock, my desktop does not get cluttered with screenshots and and downloads folder doesnt get synced with icloud so im not wasting storage space on useless screenshots.

Also it installs to the system all the fonts stored in the repository's "fonts" folder, so its a way to backup your fonts

#### What now?

Now that we understand how this works, it's time for the fun part. Clone this repository from this [link](git), customize it as per your requirements, include your software (ensure no additional steps are necessary, and if there are, incorporate them into a script), identify any system configurations that can be adjusted via the terminal, save your modifications to your repository, and when you're prepared, execute your script in the terminal using the following command:

```shell
curl -sSL https://github.com/{YOUR_USERNAME}/{YOUR_REPOSITORY_NAME}/raw/main/install.sh | sh

# Dont forget to replace the {YOUR_USERNAME} and {YOUR_REPOSITORY_NAME} strings with your own values!
```

Sometimes curl will return a cached value, so if you are actively editing your scripts and testing them, you might not see your changes reflected, if this happens run your command explicity saying that you dont want to use cached files:

```shell
curl -H 'Cache-Control: no-cache' -sSL https://github.com/{YOUR_USERNAME}/{YOUR_REPOSITORY_NAME}/raw/main/install.sh | sh
```

#### TL:DR

Go to the repo in this [link](git), clone it, modify it to your needs and run it in your terminal like this

#### You are free to go

But before you do, i have been looking for terminal commands to tweak mor system configurations but there doesnt seem to be a comprehensive list of commands, do you know some other system configurations that could be included in this file?