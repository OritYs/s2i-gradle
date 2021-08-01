
FROM openshift/base-centos7

ENV JAVA_VERSION 1.8.0
ENV GRADLE_VERSION 2.14


RUN yum update -y && \
  yum install -y curl && \
  yum install -y java-$JAVA_VERSION-openjdk java-$JAVA_VERSION-openjdk-devel && \
  yum clean all

ENV JAVA_HOME /usr/lib/jvm/java

RUN curl -sL -0 https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip /tmp/gradle-${GRADLE_VERSION}-bin.zip -d /usr/local/ && \
    rm /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    mv /usr/local/gradle-${GRADLE_VERSION} /usr/local/gradle && \
    ln -sf /usr/local/gradle/bin/gradle /usr/local/bin/gradle

COPY ./.s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:1001 /opt/app-root

USER 1001
EXPOSE 8080

CMD $STI_SCRIPTS_PATH/usage
