# AlBro
# Docker tensorflow example with GPU support
# Unless specified otherwise: current user = root

# Inherit from and download image with specific tf version (2.12.0) with gpu support (-gpu) -- based on Ubuntu (20.04.5 LTS)
FROM tensorflow/tensorflow:2.12.0-gpu

# choose current workdir 
WORKDIR /home

# install some OS pkgs
RUN apt-get update && \
    apt install wget && \
    apt-get -y install git && \
    apt-get update --fix-missing && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /tmp/* 

# install python pkgs // conda + conda file also possible
RUN pip install --upgrade pip && \
    pip install scipy==1.3.3 requests==2.22.0 Pillow==6.2.1 h5py==2.9.0 imageio==2.9.0 && \ 
    rm -Rf /tmp/*
	
# Add your own modules to path	
# RUN echo 'export PYTHONPATH="${PYTHONPATH}:/my/coding/dir/modules"' >> ~/.bashrc && source ~/.bashrc

# Optional: add user -- interesting when mounting directories from main OS --> UID and GID have to be specified as --build-arg 
# ARG UNAME=myusername
# ARG UID
# ARG GID
# RUN groupadd -g $GID -o $UNAME
# RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

# specifies a command that will always be executed when the container starts
ENTRYPOINT ["bash","-c"]
# specifies arguments that will be fed to the ENTRYPOINT
# e.g. start container with shell -- show nvidia-smi (verify gpu support)
CMD ["nvidia-smi && /bin/bash"]

# directly start script/calculations when container starts
# CMD ["python -c 'import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))'" ]
