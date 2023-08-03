#!/bin/sh

# 출력에 사용될 색상 변수 설정
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RESET='\033[0m'

# MariaDB 사용 가능 여부를 체크
i=0
while ! mysqladmin -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD ping >/dev/null 2>&1; do
  if [ $i -eq 0 ]; then
    echo "${YELLOW}MariaDB 서버의 동작을 대기 중입니다 ...${RESET}"
  else
    echo "${YELLOW}MariaDB 서버의 동작을 대기 중입니다 ... ${i}${RESET}"
  fi
  sleep 5
  i=$(($i+1))
done
echo "${GREEN}MariaDB 서버의 동작을 대기 완료했습니다.${RESET}"

# WordPress 코어 다운로드
wp-cli core download --allow-root

# WordPress 설정 파일 생성
wp-cli config create --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root

# WordPress 설치
wp-cli core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# 구독자 사용자 생성
wp-cli user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=subscriber --allow-root

# Astra 테마 설치 및 활성화
wp-cli theme install astra --allow-root
wp-cli theme update astra --allow-root
wp-cli theme activate astra --allow-root

# 완료 메시지 출력
cat <<EOM
${GREEN}--------------------
워드프레스 설치가 완료되었습니다.
포트: 9000
--------------------${RESET}
EOM

# PHP-FPM 서버 시작
exec /usr/sbin/php-fpm7.3 -F
