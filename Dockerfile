FROM centos:7.6.1810

RUN yum -y install git gcc cmake automake g++ mysql-devel

RUN git clone https://github.com/Tomatosky/sphinx-jieba \
    && cd sphinx-jieba \
    && git submodule update --init --recursive \
    && ./configure --prefix=/usr/local/sphinx-jieba \
    && \cp -r cppjieba/include/cppjieba src/  \
    && \cp -r cppjieba/deps/limonp src/  \
    && make && make install \

RUN \cp -r cppjieba/dict/* /usr/local/sphinx-jieba/etc/  \
    && cd /usr/local/sphinx-jieba/ \
    && \cp etc/jieba.dict.utf8 etc/xdict/jieba.dict.utf8 \
    && \cp etc/user.dict.utf8 etc/xdict/user.dict.utf8 \
    && \cp etc/hmm_model.utf8 etc/xdict/hmm_model.utf8 \
    && \cp etc/idf.utf8 etc/xdict/idf.utf8 \
    && \cp etc/stop_words.utf8 etc/xdict/stop_words.utf8

WORKDIR /
EXPOSE 9312
ADD ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
