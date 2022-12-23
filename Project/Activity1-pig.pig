-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/ananya/inputs' USING PigStorage('\t') AS (Name:chararray,line:chararray);

-- Filter out the first 2 lines
ranked = RANK inputFile;
ranked_lines = FILTER ranked BY (rank_inputFile >2);

-- Group data using the Name column
GroupByName= GROUP inputFile BY Name;

-- Count the number of lines by each name
CountByName = FOREACH  GroupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
result = ORDER CountByName BY no_of_lines DESC;

-- Remove the output result file
rmf hdfs:///user/ananya/activity1_pig_results;

-- Store the result in HDFS
STORE result INTO 'hdfs:///user/ananya/activity1_pig_results';