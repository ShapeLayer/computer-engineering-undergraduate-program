1. 다음과 같은 조건을 만족하는 사용자 계정을 생성하시오.
    * 로그인 ID: `comeng`, UID: `3500`, 2차 그룹 : `1000`, 홈 디렉터리: `/home/comeng`
2. 위에서 생성한 사용자 계정으로 로그인한 후 다음 명령어를 수행하시오.
    * `$ (date; cat /etc/passwd /etc/shadow | grep comeng) > hw9.txt`
    * `$ (id; whoami) >> hw9.txt`
    * `$ sudo`
3. sudo 명령을 실행한 결과는 어떠한가? /etc/sudoers 파일이 존재하는가?
4. 최종 파일 hw9.txt을 e-class에 제출하시오.
