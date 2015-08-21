#/bin/bash

NAME="LD33_preEvent"
SERVER="username@yourserver.com"
LOCATION="someplace/unity/$NAME"

echo "***** clean up local zips *****"
rm Builds/OSXPlayer.app.zip
rm Builds/WindowsPlayer.zip

echo "***** make remote location *****"
ssh $SERVER mkdir "$LOCATION"

echo "***** zip and upload OSX version *****"
zip -r Builds/OSXPlayer.app.zip Builds/OSXPlayer.app
scp Builds/OSXPlayer.app.zip "$SERVER:$LOCATION/OSXPlayer.app.zip"

echo "***** zip and upload Windows version *****"
zip -r Builds/WindowsPlayer.zip Builds/WindowsPlayer.exe Builds/WindowsPlayer_Data
scp Builds/WindowsPlayer.zip "$SERVER:$LOCATION/WindowsPlayer.zip"

echo "***** upload Webplayer version *****"
ssh $SERVER mkdir "$LOCATION/WebPlayer"
scp -r Builds/WebPlayer/* "$SERVER:$LOCATION/WebPlayer/"

echo "***** creating index.html and uploading *****"
echo "<html><head><title>$NAME</title></head><body><h3>$NAME</h3><ul>" > Builds/index.html
echo "<li><a href='WindowsPlayer.zip'>Windows Player</a></li>" >> Builds/index.html
echo "<li><a href='OSXPlayer.app.zip'>OS X Player</a></li>" >> Builds/index.html
echo "<li><a href='WebPlayer/WebPlayer.html'>Web Player</a></li>" >> Builds/index.html
echo "</ul></body></html>" >> Builds/index.html
scp Builds/index.html "$SERVER:$LOCATION/index.html"
rm Builds/index.html
