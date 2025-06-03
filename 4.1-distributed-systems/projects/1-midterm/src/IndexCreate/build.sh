javac -classpath $(hadoop classpath) -d . IndexCreate.java
jar cf IndexCreate.jar IndexCreate*.class Environment.class StringUtility.class Json.class ESDocument.class ESQueryFailedException.class ESCommunicateController.class ESMapper.class
hadoop fs -rm -r /tmp/jobOutput
hadoop jar IndexCreate.jar IndexCreate --hadoop /user/hduser/10K.ID.CONTENTS /tmp/jobOutput
