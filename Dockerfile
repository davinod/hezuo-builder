FROM node

MAINTAINER Davi Diogo <davinod@gmail.com>

#ENV HEZUO_HOME /tmp/build

#KEYS WILL BE CONFIGURED WITHIN THE IMAGE
#HENCE IT IS NOT NECESSARY TO EXPOSE DURING CODEBUILD BUILD

ENV MY_KEY AKIAJL4EXWLNE2DWJILQ
ENV MY_SECRET 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

RUN echo $HEZUO_HOME

#RUN mkdir -p $HEZUO_HOME
#COPY ./hezuo-bot/* $HEZUO_HOME/

##################################################################################
#INSTALL SERVERLESS. DONT UPGRADE UNLESS YOU ARE SURE NEW VERSIONS ARE COMPATIBLE
##################################################################################

RUN npm install -g serverless@1.9.0
RUN npm --version
RUN sls --version

RUN sls config credentials --provider aws --key $MY_KEY --secret $MY_SECRET


#USE DEPLOY ONLY to TEST the IMAGE
#DEPLOY WILL BE MANAGED BY CODEBUILD

#RUN cd $HEZUO_HOME;sls deploy

