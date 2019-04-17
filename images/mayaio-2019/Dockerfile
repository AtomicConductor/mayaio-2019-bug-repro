FROM conductor-base:latest

# ---------------------------------
#   MAYA-IO 2019 INSTALLATION
# ---------------------------------

# The relative path to the MayaIO installer, e.g. "installers/Autodesk_MayaIO_2019_Linux_64bit.run"
ARG MAYAIO_2019_INSTALLER

# The autodesk license server host address, e.g. "42.052.12.200"
ARG AUTODESK_LICENSE_SERVER

# Copy the maya installer into the /tmp directory of the image
COPY ${MAYAIO_2019_INSTALLER} /tmp/mayaio2019-installer.run

# Execute the maya installer with no human intervention.  
# Cleanup afterwards. Note that the installer .run file deletes itself by default.
RUN chmod +x /tmp/mayaio2019-installer.run && \
    /tmp/mayaio2019-installer.run \
      --phase2 \
      --nox11 \
      --noprogress \
      --quiet \
      --target /tmp/install/mayaio2019 \
      -- ${AUTODESK_LICENSE_SERVER} && \
  rm -rf /tmp/install/mayaio2019



