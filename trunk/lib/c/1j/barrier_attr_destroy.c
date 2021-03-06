/*
 * $QNXLicenseC:
 * Copyright 2007, QNX Software Systems. All Rights Reserved.
 * 
 * You must obtain a written license from and pay applicable license fees to QNX 
 * Software Systems before you may reproduce, modify or distribute this software, 
 * or any work that includes all or part of this software.   Free development 
 * licenses are available for evaluation and non-commercial purposes.  For more 
 * information visit http://licensing.qnx.com or email licensing@qnx.com.
 *  
 * This file may contain contributions from others.  Please review this entire 
 * file for other proprietary rights or license notices, as well as the QNX 
 * Development Suite License Guide at http://licensing.qnx.com/license-guide/ 
 * for other information.
 * $
 */




#include <pthread.h>

int pthread_barrierattr_destroy(pthread_barrierattr_t *attr) {
	return pthread_mutexattr_destroy((pthread_mutexattr_t *)attr);
}

/* Only for binary compatibility with 2.0 programs */
#include <sync.h>

int (barrier_attr_destroy)(barrier_attr_t *attr) {
	return pthread_barrierattr_destroy((pthread_barrierattr_t *)attr);
}

__SRCVERSION("barrier_attr_destroy.c $Rev: 153052 $");
