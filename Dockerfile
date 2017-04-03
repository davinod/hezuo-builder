FROM amazonlinux

MAINTAINER Davi Diogo <davinod@gmail.com>

ENV HEZUO_HOME /tmp/hezuo-builder

#############################################################
#KEYS WILL BE CONFIGURED WITHIN THE IMAGE
#HENCE IT IS NOT NECESSARY TO EXPOSE DURING CODEBUILD BUILD
#############################################################

ENV MY_KEY <ACCESS_KEY>
ENV MY_SECRET <SECRET_KEY>

RUN echo $HEZUO_HOME
RUN mkdir -p $HEZUO_HOME

##########################
# COPY FILES INTO IMAGE
#########################

COPY ./files/* $HEZUO_HOME/
RUN ls -ltr $HEZUO_HOME/

##########################
# INSTALL PIP and AWS-CLI
##########################

RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py --user
ENV PATH ~/.local/bin:$PATH
RUN pip --version
RUN pip install awscli --upgrade --user
RUN aws --version

#########################################################
# INSTALL OTHER PIP PACKAGES DEFINED IN REQUREMENTS.TXT
########################################################

RUN pip install -r $HEZUO_HOME/requirements.txt 

#######################
# INSTALL NPM
#######################

RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash
RUN yum -y install nodejs
RUN npm --version

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

