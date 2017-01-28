# Set your prefered build dir
BUILDDIR=/opt && \
cd $BUILDDIR && \
\
# Install dependences
sudo apt-get update && \
sudo apt-get install -y \
		build-essential \
		git \
		libsqlite3-dev \
		software-properties-common \
		sqlite3 \
		sqlite3-doc && \
\
# Add brightbox ppa for the latest version of ruby
sudo apt-add-repository -y \
		ppa:brightbox/ruby-ng && \
\
# Install ruby (2.2 in this example)
sudo apt-get update && \
sudo apt-get install -y \
		ruby2.2 \
		ruby2.2-dev && \
\
# Install bundler using gem
sudo gem install bundler
