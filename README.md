#sysbench-io-tests#
This is a set of simple scripts to kick off various a sysbench tests with a given test numbers.  The sysbench results will be stored in a subdir 'res#'.  Then the generate_graph.sh will parse all the results subdirs and generate a PDF with two graphs, one for sysbench TPS and one for sysbench response time where the X axis is time.

##requirements##
Whatever version of sysbench you want.  The run.threads shell script currently requires the 'zipf' distribution in sysbench, which is available [here](https://code.launchpad.net/~vadim-tk/sysbench/zipf-distribution) and you can learn more about [here](http://www.mysqlperformanceblog.com/2012/05/09/new-distribution-of-random-generator-for-sysbench-zipf/)

The sysbench client is run on the test machine and results are stored there locally.

On the machine you wish to generate graphs on (I do this on my laptop), I get the results data copied over and beyond that I need to have 'R' installed with the 'ggplot2' library.  You also need Perl, any version should do, to parse the sysbench data.  This could be done in R, but I'm much better at Perl so far.  


##rough flow##

### Setup sysbench ###
1. install bzr on the test machine
1. bzr clone your desired sysbench
1. build sysbench following README instructions, you'll likely need several dependencies to get it working
1. make install sysbench, or at least get it in your path

### Setup test environment ###
1. Get mysql installed and configured as you'd like.
1. Prepare the sbtest database, particularly pay attention to how many tables you need.  I'd recommend following the instructions [here](http://www.percona.com/docs/wiki/benchmark:sysbench:olpt.lua).  Note that a copy of the lua tests are included in this repository.
1. Adjust run.threads with the parameters you want.  

### Run test ###
1. Be sure mysql/postgres is configured as you want for your test run
1. Document what you are testing for the test run (pick a number for it).  See results_list.txt.
1. Restart mysql/postgres so you have a level playing field
1. run `sh run.threads <testnum>`.  This will kick off a series of queries on your test tables to load them into memory, and then kick off the sysbench.
    - To test with Postgres: `sh run.threads <testnum> pgsql`. The default `HOST` and `PORT` are `localhost` and `5432` respectively. Ensure to set these if running different settings
1. repeat with all the different variations you want to test

### Generate graph data ###
1. Copy the res* subdirs to the machine you will generate graphs on (if necessary)
1. Run `generate_graph.sh`.  This will parse all the results available (into `all_res.data`) and generate a `result_graph.pdf` (see example).  This can be done repeatedly as your tests are running if you are obsessive-compulsive about seeing how your tests are going.
