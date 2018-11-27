FROM concourse/docker-image-resource:latest

COPY multi-login.sh /opt/resource/

RUN set -eux; \
    sed -i '/source .*$/a source $(dirname $0)/multi-login.sh' /opt/resource/out; \
    sed -i '/log_in .*$/a multi_login' /opt/resource/out;
