MAINDIR=$(pwd)

# Darknet
git clone https://github.com/AlexeyAB/darknet.git
cd darknet
mkdir build_release
cd build_release
cmake ..
cmake --build . --target install --parallel $(nproc)
sudo cp libdarknet.so /usr/local/lib/
sudo cp include/darknet.h /usr/local/include/
sudo ldconfig

# DarkHelp
sudo apt-get install -y cmake build-essential libtclap-dev libopencv-dev \
                        libx11-dev libfreetype6-dev libxrandr-dev libxinerama-dev \
                        libxcursor-dev libmagic-dev libpoppler-cpp-dev
cd ${MAINDIR}
git clone https://github.com/stephanecharette/DarkHelp.git
cd DarkHelp
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
make package
sudo dpkg -i darkhelp*.deb

# DarkMark
cd ${MAINDIR}
git clone https://github.com/stephanecharette/DarkMark.git
cd DarkMark
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
make package
sudo dpkg -i darkmark*.deb