package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.ui.ModelMap;

/**
 * 
 *	车位操作
 * @author jiaosf
 * @since 2015-7-31
 */
public interface ICarPortService {
	
	/**
	 * 车位数据
	 * @param inputStream
	 * @param unitId
	 * @param model
	 * @throws IOException 
	 */
	public void importCarPort_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException;

}
