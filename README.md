This repo gives instructions for how to build the SpectroGK and its dependencies inside a Docker image.

1. Build the Dockerfile:

```
docker build -t singularity-image . 
```

2. Open the docker image and add spack to it. (The lines to do this are commented out in the Dockerfile, because I could never get them to work in the build script... even though the same steps work inside the container)

```
docker run -it -v ~/.ssh:/root/.ssh singularity-image
```

Here, replace `~/.ssh` with the location of your ssh keys (to allow you to install SpectroGK).

Then in the image shell, do

```
cd spack
. share/spack/setup-env.sh
spack env create spackenv ../spack.yaml
spack env activate -p spackenv
spack external find
spack install
```

The last of these commands might take a few hours...

3. Install SpectroGK with

```
git@github.com:JosephThomasParker/SpectroGK.git
cd SpectroGK
python3 -m venv venv_cppyy
. venv_cppyy/bin/activate
pip3 install -r requirements.txt
spack load llvm
cmake -DCMAKE_BUILD_TYPE=Release -DCUDA=True -DCMAKE_MODULE_PATH=venv_cppyy/lib/python3.10/site-packages/cppyy_backend/cmake/ -DCPPYY_MODULE_PATH=venv_cppyy/lib/python3.10/site-packages/cppyy_backend/cmake/ . -B build_cppyy_gcc11
cmake --build build_cppyy_gcc11/ -j
```
