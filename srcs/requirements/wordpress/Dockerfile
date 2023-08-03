# 베이스 이미지를 사용하여 Docker 이미지를 생성
FROM debian:buster

# 패키지 관리자를 업데이트하고, 시스템 업그레이드 및 필요한 패키지를 설치
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl mariadb-client php7.3-fpm php-mysql

# WP-CLI 다운로드 및 설정
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin && \
    ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp-cli

# 디렉토리 및 사용자 설정
RUN mkdir -p /var/www/html/wordpress /run/php && \
    usermod -G www-data -a www-data && \
    chown -R www-data:www-data /var/www/

# PHP-FPM 설정 파일 및 스크립트 복사
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/setup.sh /setup.sh

RUN chmod +x setup.sh

# 작업 디렉토리 설정
WORKDIR /var/www/html/wordpress

# 포트 노출
EXPOSE 9000

# 진입점 설정
ENTRYPOINT ["sh", "/setup.sh"]
