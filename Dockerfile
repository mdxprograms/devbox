FROM jare/vim-bundle

MAINTAINER mdxprograms <mdx.programs@gmail.com>

USER root

COPY init-vim.sh /tmp/init-vim.sh

RUN echo "http://nl.alpinelinux.org/alpine/edge/testing" \
    >> /etc/apk/repositories \
    && echo "http://nl.alpinelinux.org/alpine/edge/community" \
    >> /etc/apk/repositories \
    && apk --no-cache add \
    bash \
    zsh \
    curl \
    git \
    htop \
    libseccomp \
    mosh-server \
    openrc \
    openssh \
    py2-pip \
    && pip install powerline-status \
    && echo "set shell=/bin/zsh" \
    >> $UHOME/.vimrc \
    && sh /tmp/init-vim.sh

RUN rc-update add sshd \
    && rc-status \
    && touch /run/openrc/softlevel \
    && /etc/init.d/sshd start > /dev/null 2>&1 \
    && /etc/init.d/sshd stop > /dev/null 2>&1

EXPOSE 80 8080

COPY start.bash /usr/local/bin/start.bash
ENTRYPOINT ["bash", "/usr/local/bin/start.bash"]
