FROM --platform=linux/amd64 ubuntu:22.04
ENV TZ=Pacific/Auckland

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN echo "#Install packages";\
    apt-get update;\
    apt-get install -y \
        wget ttf-mscorefonts-installer xdg-utils zenity fonts-wqy-zenhei \
        libgconf-2-4 libgtk2.0-0 libnss3 libxss1 libasound2 \
        xvfb xfwm4 dbus-x11;\
    apt-get autoclean;\
    DEBIAN_FRONTEND=noninteractive TZ=${TZ} apt-get -y install tzdata x11vnc net-tools;\
    apt-get -y install x2goserver openbox xterm;\
    apt-get clean

#RUN wget https://download.screamingfrog.co.uk/products/seo-spider/screamingfrogseospider_12.6_all.deb
RUN echo "#Download and install screamingfrog geo spider";\
    wget https://download.screamingfrog.co.uk/products/seo-spider/screamingfrogseospider_17.2_all.deb;\
    mkdir $HOME/.ScreamingFrogSEOSpider;\
    touch $HOME/.ScreamingFrogSEOSpider/spider.config;\
    ln -s $HOME/.ScreamingFrogSEOSpider $HOME/ScreamingFrogSEOSpider;\
    dpkg -i screamingfrogseospider_17.2_all.deb;\
    rm screamingfrogseospider_17.2_all.deb;

# TZ=Etc/UTC
#RUN DEBIAN_FRONTEND=noninteractive TZ=Pacific/Auckland apt-get -y install tzdata x11vnc net-tools;

RUN echo 'eula.accepted=11' >> /root/.ScreamingFrogSEOSpider/spider.config

ENV DISPLAY :99

# COPY licence.txt /root/.ScreamingFrogSEOSpider/licence.txt

COPY start_screamingfrog.sh /root/start_screamingfrog.sh
RUN chmod a+x /root/start_screamingfrog.sh

ENTRYPOINT ["/root/start_screamingfrog.sh"]
