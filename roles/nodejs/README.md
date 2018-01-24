# login as root (might be required depending on install)
su -
# list all global packages
npm ls -g --depth=0
# list all local (project) packages
npm ls -p --depth=0
# remove all global packages
npm ls -g --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' | xargs npm -g rm
# remove all local packges
npm ls -p --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' | xargs npm -p rm

# NOTE (optional): to use node with sudo you can add the bins to /usr/bin
# NOTE $PATHTONODEINSTALL is where node is installed (e.g. /usr/local/node)
sudo ln -s $PATHTONODEINSTALL/bin/node /usr/bin/node
sudo ln -s $PATHTONODEINSTALL/bin/npm /usr/bin/npm
