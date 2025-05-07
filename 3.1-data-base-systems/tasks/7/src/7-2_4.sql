SELECT movie_script FROM movieTBL WHERE movie_id=1
INTO OUTFILE '<path>/Movies/Schindler_out.txt'
LINES TERMINATED BY '\\n';

SELECT movie_film FROM movieTBL WHERE movie_id=3
INTO DUMPFILE '<path>/Movies/Mohican_out.mp4';
