# mysql-tpcc-test

## 1. help

```
Usage:
	-u|--user mysql-user			mysql user
	-p|--password mysql-passwd		mysql password
	-h|--host [mysql-host]			mysql host, default: 127.0.0.1 or localhost
	-P|--port [mysql-port]			mysql port, default: 3306
	-W|--warehouses number-of-warehouses	specify how many warehouses
	-S|--step number			decide how many load data threads, example: if warehouse=20 and step=5, there will be 4 threads
	-w|--warm-time number-of-seconds	tpcc time to warm up the data
	-t|--time number-of-seconds		tpcc max running time
	-s|--schemas number-of-schemas		default:1, specify how many schemas
	-T|--thread thread-numbers		tpcc thread nums
	-c|--cmd 				includes: prepare | load | run | clean | all , default: all
							prepare: create databases, tables and add indexes
							load: load data
							run: run tpcc test
							clean: clean test database
							all: all of the above
	-l|--logdir [dirpath]			log dir
	-r|--reset				need to clear log dir
```

**NOTE：**

1. if --schemas=2, the script will create databases tpcc${thread-nums}_s0 and tpcc${thread-nums}_1.


## 2. Example

1. prepare: create database and tables, add indexes
```bash
./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --cmd=prepare
```

2. load data in parallel
```bash
# cmd
./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --cmd=load
# threads list
$ ps -xf | grep load
26490 pts/1    S+     0:00      \_ /bin/bash ./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --logdir=./log --cmd=load
26518 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 1 -m 1 -n 16
26527 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 2 -m 1 -n 6
26534 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 3 -m 1 -n 6
26541 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 4 -m 1 -n 6
26550 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 2 -m 7 -n 12
26557 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 3 -m 7 -n 12
26564 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 4 -m 7 -n 12
26573 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 2 -m 13 -n 18
26580 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 3 -m 13 -n 18
26587 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -l 4 -m 13 -n 18

# wait for tpcc8_s0 to complete loading data

# ps again
28861 pts/1    S+     0:00      \_ /bin/bash ./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --logdir=./log --cmd=load
29043 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 1 -m 1 -n 16
29052 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 2 -m 1 -n 6
29059 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 3 -m 1 -n 6
29066 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 4 -m 1 -n 6
29075 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 2 -m 7 -n 12
29082 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 3 -m 7 -n 12
29089 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 4 -m 7 -n 12
29098 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 2 -m 13 -n 18
29105 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 3 -m 13 -n 18
29112 pts/1    S+     0:00          \_ /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_load -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -l 4 -m 13 -n 18
```

3. run tpcc test
```bash
# cmd
./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --logdir=./log --cmd=run
# thread list
$ ps xf | grep tpcc
29708 pts/1    Sl     0:00 /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_start -h 192.168.0.247 -d tpcc8_s1 -u admin -p admin -w 16 -c 8 -r 10 -l 20
29693 pts/1    Sl     0:00 /home/ubuntu/test/tpcc-mysql-test/tpcc-mysql/tpcc_start -h 192.168.0.247 -d tpcc8_s0 -u admin -p admin -w 16 -c 8 -r 10 -l 20
```

4. cleanup all databases
```bash
./test.sh --user=admin --password=admin --host=192.168.0.247 --warehouses=16 --step=6 --warm-time=10 --schemas=2 --thread=8 --time=20 --logdir=./log --cmd=cleanup
```

**NOTE:**

1. `--cmd=all` includes all other commands(prepare, load, run, cleanup).
2. If want reset log dir, need add `--reset` option.
3. The default log directory is `/tmp/tpcc_log`, you can specify other directory by `--logdir` option.
