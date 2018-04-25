#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#define SEMKEY 2345
#include "sem.h"

int main2()
{
	int ret,semid;
	int pid;
	//创建信号量
	//参数1 键值 同于 共享内存,2 创建一个信号量，3检查是否有一样的
	semid=semget(SEMKEY,1,IPC_EXCL);
	if(semid<0)
	{
		//创建
		semid=semget(SEMKEY,1,IPC_CREAT|0640);
		if(semid<0)
		{
			perror("semget");
			return -1;
		}
	}
	//初始化信号量
	init_sem(semid,0);

	//创建子进程
	if(!(pid=fork()))
	{
		//child
		printf("in child will sleep 5\n");
		sleep(5);
		printf("in child will out\n");
		v_sem(semid);//释放信号量
		return 0;
	}
	//parent
	p_sem(semid);
	printf("parent is running\n");
	wait(&pid);
	del_sem(semid);	
}
