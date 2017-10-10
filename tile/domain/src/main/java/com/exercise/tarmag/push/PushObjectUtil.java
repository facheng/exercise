package com.dt.tarmag.push;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dt.tarmag.vo.PushVo;

public class PushObjectUtil {

	/**
	 * 对象转换
	 * @return
	 */
	public static List<PushVo> zhuanhuan(List<Map<String, Object>> pushs){
		List<PushVo> pushVos = new ArrayList<PushVo>();
		for(Map<String, Object> push : pushs){
			PushVo pushVo = new PushVo();
			pushVo.setAppType((String)push.get("appType"));
			pushVo.setContent((String)push.get("content"));
			pushVo.setId(new Long(push.get("id").toString()));
			pushVo.setnToken((String)push.get("nToken"));
			pushVo.setType((String)push.get("type"));
			pushVo.setUserId(new Long(push.get("userId").toString()));
			pushVo.setDeviceModel((String)push.get("deviceModel"));
			pushVo.setDeviceType((String)push.get("deviceType"));
			pushVos.add(pushVo);
		}
		return pushVos;
	}
}
