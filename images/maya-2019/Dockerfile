FROM conductor-base:latest

# ---------------------------------
#   MAYA 2019 INSTALLATION
# ---------------------------------

# The relative path to the Maya installer, e.g. "installers/Autodesk_Maya_2019_Linux_64bit.tgz"
ARG MAYA_2019_INSTALLER

# Copy the maya installer into the /tmp directory of the image
COPY ${MAYA_2019_INSTALLER} /tmp/maya2019.tgz

# Extract the maya .tgz and install maya/bifrost rpms.  Cleanup afterwards
RUN mkdir -p /tmp/install/maya2019 && \
    tar -xzf /tmp/maya2019.tgz -C /tmp/install/maya2019 && \
    rpm -ivh /tmp/install/maya2019/Maya2019*.rpm && \
    rpm -ivh /tmp/install/maya2019/bifrost.rpm && \
    rm -rf   /tmp/install/maya2019 && \
    rm /tmp/maya2019.tgz 
    


