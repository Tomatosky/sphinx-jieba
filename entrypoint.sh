#!/bin/bash
echo "建立索引"
/usr/local/sphinx-jieba/bin/indexer -c /usr/local/sphinx-jieba/sphinx.conf

echo "启动服务"
/usr/local/sphinx-jieba/bin/searchd -c /usr/local/sphinx-jieba/sphinx.conf