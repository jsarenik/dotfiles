#!/bin/sh -x

NODE_VERSION=0.10.36
NPM_VERSION=1.4.28
COFFEE_VERSION=1.8.0
GRUNT_VERSION=0.1.13

NPM_GLOBAL_PREFIX=`npm prefix -g`
NPM_PREFIX=`npm prefix`

rm -rf $NPM_GLOBAL_PREFIX/lib/node_modules
rm -rf $NPM_PREFIX/node_modules

rm -rf ~/.nvm

set -e

git clone git://github.com/creationix/nvm.git ~/.nvm

. $HOME/.nvm/nvm.sh

nvm install v$NODE_VERSION
nvm alias default v$NODE_VERSION

npm install -g npm@$NPM_VERSION
npm install -g coffee-script@$COFFEE_VERSION
npm install -g grunt-cli@$GRUNT_VERSION

npm install grunt
#npm link grunt

echo Now run:
echo grunt prepare

#npm ddp
#npm prune
