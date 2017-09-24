/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.push.notifier;

import com.dt.tarmag.vo.PushVo;

/**
 * @author 👤wisdom 
 *
 */
public interface INotifier {
	public abstract void beginNotify(String appType) throws Exception;

	public abstract void endNotify() throws Exception;

	public abstract void nofity(PushVo pushVo) throws Exception;
}
