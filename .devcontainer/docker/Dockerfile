FROM archlinux/archlinux:base

ARG USERNAME=${USERNAME:-abc}
ARG PUID=${PUID:-1000}
ARG PGID=${PGID:-1000}

RUN pacman -Syu --noconfirm

RUN pacman -Sy \
    bash \
    sudo \
    git \
    openssh \
    docker \
    docker-compose \
    --noconfirm

ENV HOME=/config

# Create the user
RUN groupadd --gid $PGID $USERNAME \
    && useradd --uid $PUID --gid $PGID -G wheel -s /bin/bash -m -d $HOME -p $USERNAME $USERNAME \
    && echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel \
    && chmod 0440 /etc/sudoers.d/wheel

COPY scripts/ /

RUN chmod +x /setup_container.sh /clone-repo.sh

ENTRYPOINT [ "sleep", "infinity" ]
