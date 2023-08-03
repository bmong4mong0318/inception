FROM debian:buster

# SSL 인증서를 저장할 디렉토리 생성
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    mkdir -p /etc/ssl  

# Nginx 설정 파일을 복사
COPY conf/default.conf /etc/nginx/conf.d/default.conf  

# setup.sh 스크립트를 복사
COPY ./tools/setup.sh /setup.sh  

# setup.sh 스크립트에 실행 권한 부여
RUN chmod +x setup.sh  

# 컨테이너가 외부에 노출할 포트 번호 설정
EXPOSE 443  

# 컨테이너가 시작될 때 setup.sh 스크립트 실행
ENTRYPOINT ["sh", "/setup.sh"]  
