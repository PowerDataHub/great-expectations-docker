FROM python:3-slim

ARG BUILD_DATE                                                                                                                                                       
ARG VCS_REF                                                                                                                                                          
                                                                                                                                                                     
LABEL maintainer="Eduardo Bizarro <edbizarro@gmail.com>" \
  org.label-schema.name="edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.description=":whale2: Docker image for great_expectations (https://greatexpectations.io)." \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \ 
  org.label-schema.vcs-url="https://github.com/PowerDataHub/great-expectations-docker" \ 
  org.label-schema.vcs-ref=$VCS_REF

ADD ./requirements.txt ./

RUN apt-get update -yqq \
  && apt-get install --no-install-recommends -yqq ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache \
  && pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt  

# Run great_expectations
CMD ["great_expectations"]