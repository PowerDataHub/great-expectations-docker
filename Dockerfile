FROM python:3-alpine

ARG BUILD_DATE                                                                                                                                                       
ARG VCS_REF                                                                                                                                                          
                                                                                                                                                                     
LABEL maintainer="Eduardo Bizarro <edbizarro@gmail.com>" \
  org.label-schema.name="edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.description="" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \ 
  org.label-schema.vcs-url="" \ 
  org.label-schema.vcs-ref=$VCS_REF

ADD ./requirements.txt ./

RUN apk --update --no-cache add python openssl ca-certificates py-openssl wget lapack libstdc++
RUN apk --update --no-cache add --virtual .builddeps \      
      linux-headers \
      musl-dev \
      gdb \
      gfortran \
      lapack-dev \
      openblas-dev \            
      openssl-dev \
      python3-dev \
      py3-pip \
      build-base \
  && pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt --install-option="--jobs=$(nproc)" \
  && apk del --purge .builddeps \
  && rm -rf /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/* \
        /root/.cache

  
  
# Run dbt
CMD ["great_expectations"]