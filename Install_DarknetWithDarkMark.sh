MAINDIR=$(pwd)

# Darknet
git clone https://github.com/AlexeyAB/darknet.git
cd darknet
sed -i.bak \
    -e "s/GPU=0/GPU=1/g" \
    -e "s/CUDNN=0/CUDNN=1/g" \
    -e "s/CUDNN_HALF=0/CUDNN_HALF=1/g" \
    -e "s/OPENCV=0/OPENCV=1/g" \
    -e "s/LIBSO=0/LIBSO=1/g" \
    -e "s/USE_CPP=0/USE_CPP=1/g" \
    Makefile

mkdir build_release
cd build_release
cmake ..
cmake --build . --target install --parallel $(nproc)

cd ${MAINDIR}/darknet
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
