1. 자신의 HOME 디렉터리 내에서 linux_hw3 서브디렉터리를 생성하고 그 아래 vi를 이용하여 limits.h, str.h, str.c를 생성하시오.
2. 위와 같은 생성한 후 자신의 홈 디렉터리에서 cp linux_hw3 linux_hw7을 실행하여 linux_hw7라는 별도의 디렉터리를 생성하시오.

* linux_hw3 아래에 앞 페이지의 str.c를 복사하여 test.txt, exec.txt, exec2.txt exec3.txt를 생성하고 temp라는 디렉터리도 생성하시오.  
1. linux_hw3 디렉터리 아래에서 다음과 같은 순서대로 명령을 수행한 후, 해당 파일을 제출하시오.
    * `$ (date; ls -al [ef]*) > hw3-1`
    * `$ find . –name str.c –exec mv {} temp \;`
    * `$ grep –n –i str *.h > hw3-2`
    * `$ ls –al temp > hw3-3`
2. 파일 hw3-1, hw3-2, hw3-3의 내용을 e-class에 제출함
