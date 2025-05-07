USE movieDB;
TRUNCATE movieTBL;

INSERT INTO movieTBL VALUES (1, '쉰들러 리스트', '스필버그', '리암 니슨',
  LOAD_FILE('<path>/Movies/Schindler.txt'), LOAD_FILE('<path>/Movies/Schindler.mp4')
);

INSERT INTO movieTBL VALUES (2, '쇼생크 탈출', '프랭크 다라본트', '팀 로빈스',
  LOAD_FILE('<path>/Movies/Shawshank.txt'), LOAD_FILE('<path>/Movies/Shawshank.mp4')
);

INSERT INTO movieTBL VALUES (3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
  LOAD_FILE('<path>/Movies/Mohican.txt'), LOAD_FILE('<path>/Movies/Mohican.mp4')
);

SELECT * FROM movieTBL;
