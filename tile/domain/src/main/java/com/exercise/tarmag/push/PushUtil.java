/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.push;

import java.lang.reflect.Modifier;

import org.apache.log4j.Logger;

import com.dt.framework.util.StringUtils;
import com.dt.tarmag.push.notifier.INotifier;
import com.dt.tarmag.vo.PushVo;

/**
 * @author 👤wisdom
 *
 */
public class PushUtil {
	public static final Logger logger = Logger.getLogger(PushUtil.class);
	
	/**
	 * 消息推送 
	 * @param pushVo
	 * @throws Exception
	 */
	public static void push(PushVo pushVo) throws Exception {
		try {
			//根据设备类型获取指定的notifier
			Class<?> notifierClass = Class.forName(INotifier.class
					.getPackage().getName()
					+ "."
					+ StringUtils.capitalize(pushVo.getDeviceType())
					+ "Notifier");
			if (Modifier.isAbstract(notifierClass.getModifiers())
					|| notifierClass.isAnnotationPresent(Deprecated.class))
				return;
			INotifier notifiter = (INotifier) notifierClass.newInstance();
			notifiter.beginNotify(pushVo.getAppType());
			notifiter.nofity(pushVo);
			notifiter.endNotify();
		} catch (ClassNotFoundException e) {
			logger.warn("Unsupport this deviceType[" + pushVo.getDeviceType()
					+ "]", e);
		}
	}
}
