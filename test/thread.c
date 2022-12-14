#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

void *thread(void *vargp)
{
	sleep(1);
	printf("thread\n");
	return NULL;
}

int main()
{
	pthread_t thread_id;
	printf("init\n");
	pthread_create(&thread_id, NULL, thread, NULL);
	pthread_join(thread_id, NULL);
	printf("deinit\n");
	exit(0);
}
