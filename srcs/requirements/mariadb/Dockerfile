FROM debian:buster

# 패키지 업데이트 및 MariaDB 설치, 불필요한 패키지 삭제
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server \
    mariadb-client \
    vim && \
    rm -rf /var/lib/apt/lists/*

# MariaDB 실행을 위한 디렉토리 생성 및 권한 설정
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

# setup.sh 스크립트 복사
COPY ./tools/setup.sh /setup.sh

# setup.sh 스크립트에 실행 권한 부여, 기존의 MariaDB 설정 파일 삭제
RUN chmod +x setup.sh && \
    rm -f /etc/mysql/mariadb.conf.d/50-server.cnf

# 컨테이너가 외부에 노출할 포트 번호 설정
EXPOSE 3306

# MariaDB 설정 파일 복사
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# 컨테이너가 시작될 때 setup.sh 스크립트 실행
ENTRYPOINT ["sh", "/setup.sh"]

# 컨테이너 시작 시 MariaDB 실행
CMD ["mysqld", "--bind-address=0.0.0.0"]
