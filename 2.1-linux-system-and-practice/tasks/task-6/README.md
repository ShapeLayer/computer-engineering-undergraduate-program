* Linux_hw3 디렉터리에서 다음과 같은 순서대로 명령을 수행하시오. ⏎은 엔터키를 의미한다.
    * `$ (echo ”1st command ``cat *.h`` shows” > hw6-1; sleep 500) &`
    * `$ (echo ”2nd command ``cat *.c`` shows”; sleep 400) >> hw6-1 &`
    * `$ less /etc/services`⏎  Ctrl-z
    * `$ (sleep 200; ll –R ~/linux_hw[3-5]) > hw6.out &`
    * `$ nohup (sleep 200; echo ”With nohup ``ll –R ~/linux_hw3``”) &`
    * `$ (date; jobs) > hw6-2`
    * `$` Ctrl-d 또는 exit ⏎
* 다른 CMD 창을 실행시켜서 다음 명령을 수행함
    * `$ (date; jobs) >> hw6-2`


* 제출물: hw6-1, hw6-2, hw6.out과 nohup.out 파일의 내용을 e-class에 제출하시오.
* `ll`은 `ls –al`로 alias된 명령어라고 가정함.
* `(date; jobs)` 명령어 대신에 `ps –f`, `ps a`, `top`과 같은 명령을 수행하면서 프로세스의 실행 과정을 살펴보시오.
