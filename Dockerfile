FROM registry.fit2cloud.com/public/python:v3
LABEL maintainer="jasonzhao <jason.zhao@hp.com>"

COPY requirements /opt/coco/requirements
WORKDIR /opt/coco

RUN yum -y install epel-release && \
    cd requirements && \
    yum -y install $(cat rpm_requirements.txt) && \
    pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/ || pip install -r requirements.txt

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

COPY . /opt/coco
VOLUME /opt/coco/data

RUN  echo > config.yml

EXPOSE 2222
ENTRYPOINT ["./entrypoint.sh"]