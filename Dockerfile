FROM ubuntu:20.10
LABEL maintainer="JuliBCN <julibcn@gmail.com>"

ENV USER=root
ENV PASSWORD=C0nn3ct!
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY bubbob /dos/bubbob

RUN apt-get update && \
  apt-get install -y tightvncserver ratpoison dosbox novnc websockify && \
  mkdir ~/.vnc/ && \
  mkdir ~/.dosbox && \
  echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd && \
  chmod 0600 ~/.vnc/passwd && \
  echo "set border 0" > ~/.ratpoisonrc  && \
  echo "exec dosbox -conf ~/.dosbox/dosbox.conf -fullscreen -c 'MOUNT C: /dos' -c 'C:' -c 'cd bubbob' -c 'BUBBLE.EXE'">> ~/.ratpoisonrc && \
  export DOSCONF=$(dosbox -printconf) && \
  cp $DOSCONF ~/.dosbox/dosbox.conf && \
  sed -i 's/usescancodes=true/usescancodes=false/' ~/.dosbox/dosbox.conf && \
  openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/novnc.pem -out ~/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@examp$

EXPOSE 80

CMD vncserver && websockify -D --web=/usr/share/novnc/ --cert=~/novnc.pem 80 localhost:5901 && tail -f /dev/null
