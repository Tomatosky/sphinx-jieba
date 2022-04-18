FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install gcc cmake automake g++ libmysqld-dev git

RUN git clone https://github.com/Tomatosky/sphinx-jieba \
    && cd sphinx-jieba \
    && git submodule update --init --recursive \
    && ./configure --prefix=/usr/local/sphinx-jieba \
    && \cp -r cppjieba/include/cppjieba src/  \
    && \cp -r cppjieba/deps/limonp src/  \
    && make install

WORKDIR /usr/local/sphinx-jieba/xdict/
RUN \cp -r /sphinx-jieba/cppjieba/dict/* ./

WORKDIR /usr/local/sphinx-jieba/log
WORKDIR /usr/local/sphinx-jieba/data
WORKDIR /
EXPOSE 9312
ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
