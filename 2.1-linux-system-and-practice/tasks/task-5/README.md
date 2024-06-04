1. HW#4에서 사용했던 디렉터리 아래에 존재하는 file.txt, test.txt, exec.txt, exec2.txt, exec3.txt 파일과 새롭게 생성한 temp2 디렉터리에 대해서 file.txt의 접근권한을 ---------로 exec2.txt와 exec3.txt의 접근권한을 rwxrw-r--로 변경하시오. 또한, temp2의 접근 권한을 ----------로 변경하시오.
2. file.txt의 접근권한이 ---------임을 확인하고, file.txt에 대해 하드링크와 심볼릭링크 파일을 생성한 후  생성되는 경우 각각의 파일 접근권한이 서로 동일한지 확인하시오. 
    * `$ (ll_sort; date) > hw5-1`
3. file.txt의 접근권한을 rwxr-----로 변경하시오. file.txt에 대해 하드링크와 심볼릭링크 파일의 접근권한이 동일하게 변경되었는지 확인하시오.
    * `$ (ll_sort; umask) >> hw5-1`
3. 파일 hw5-1의 내용을 e-class에 제출하시오.
