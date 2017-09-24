package com.dt.framework.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * @author wei
 */
public class SpringContext implements ApplicationContextAware {
	private static ApplicationContext applicationContext;
	
	private SpringContext(){}
	
	@SuppressWarnings("unchecked")
	public static<T> T getBean(String beanname) {
	   return (T)applicationContext.getBean(beanname);
    }

	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		applicationContext = ctx;
	}
}