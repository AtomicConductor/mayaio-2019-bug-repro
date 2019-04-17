FROM centos:7.5.1804

# Install maya/general dependencies

RUN yum -y update && \
  yum install -y \
    epel-release && \
  yum install -y \
    /usr/lib64/libXpm.so.4 \
    alsa-lib \
    atk \
    audiofile \
    audiofile-devel \ 
    bc \
    compat-db47 \
    e2fsprogs-libs \
    fontconfig \
    freetype \
    gamin \
    gcc \
    gdk-pixbuf2 \
    glx-utils \
    gstreamer \
    gstreamer-plugins-base \
    gstreamer1 \
    gstreamer1-plugins-base \
    gtk2 \
    less \
    liberation-fonts-common \
    liberation-mono-fonts \
    liberation-sans-fonts \
    liberation-serif-fonts \
    libffi-devel \
    libGLU \
    libgomp \
    libjpeg-turbo \
    libmng \
    libpng* \
    libSM \
    libtiff \
    libX11 \
    libXaw \
    libXcomposite \
    libXcursor \
    libXdamage \
    libXfixes \
    libXi \
    libXinerama \
    libxml2-devel \
    libXmu \
    libXp \
    libXpm \
    libXrandr \
    libxslt-devel \
    libXt \
    libXtst \
    libXv \
    mesa-libGLw \
    openssl-devel \
    postgresql-libs \
    pulseaudio-libs \
    python-devel \
    python-pip \
    qt5-qtmultimedia \
    xkeyboard-config \
    xorg-x11-fonts-ISO8859-1-100dpi \
    xorg-x11-fonts-ISO8859-1-75dpi && \
      yum clean all

      
      
# ---------------------------------
#   MTOA 3.x INSTALLATION
# ---------------------------------
# The relative path to the MtoA installer, e.g. "Installers/MtoA-3.2.0.2-linux-2019.run"
ARG MTOA_INSTALLER

# Copy the installer into the /tmp directory of the image
COPY ${MTOA_INSTALLER} /tmp/mtoa3-installer.run

# Execute the installer with no human intervention. Cleanup afterwards.
RUN chmod +x /tmp/mtoa3-installer.run && \
    /tmp/mtoa3-installer.run \
      --nox11 \
      --target /tmp/install/mtoa3 \
      -- silent && \
    rm /tmp/mtoa3-installer.run && \
    rm -rf /tmp/install/mtoa3
