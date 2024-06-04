* 다음과 같은 기능을 수행하도록 alias를 지정하시오. 쉘에서 alias 명령어를 이용하는 것보다는 .bashrc 파일을 수정하는 방법을 사용하시오.
    ```
    h       =>  history
    a       =>  alias
    rmi     =>  rm -i
    cdhw3   =>  cd ~/linux_hw3
    head10  =>  head –n 10
    ll_sort =>  ls –al * | sort
    ```

1. linux_hw3 디렉터리 아래의 모든 파일을 linux_hw4로 복사하고 다음과 같은 순서대로 명령을 수행한 후, 해당 파일을 제출하시오.
    * `$ (date; a) > hw4-1`
    * `$ echo “Today is 'date' on ``uname`` system.” > hw4-2`
    * `$ find . –name “exec*” –exec ls –al {} \; > hw4-3 2>&1`
    * `$ ll_sort | grep –n exec > hw4-4`
    * `$ echo ‘``ls –al`` $PATH’ >> hw4-2`
    * `$ echo “``ls –al`` $PATH $PS1” >>  hw4-2`
    * `$ h | head10 >> hw4-4`
2. 파일 hw4-1, hw4-2, hw4-3, hw4-4의 내용을 e-class에 제출하시오.
