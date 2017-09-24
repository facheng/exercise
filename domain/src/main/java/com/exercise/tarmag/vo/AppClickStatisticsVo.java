package com.dt.tarmag.vo;


/**
 * APP 菜单点击数统计
 *
 * @author jiaosf
 * @since 2015-7-30
 */
public class AppClickStatisticsVo {
	
	/**
	 * 类型  1点击率，2转换率
	 */
	private Byte type;
	
	/**
	 * 
	 */
	private Long typeId;
	
	/**
	 * 
	 */
	private String typeName;
	
	/**
	 * 
	 */
	private String menuName;
	
	/**
	 * 点击次数
	 */
	private Long counts;
	
	/**
	 * 点击人数
	 */
	private Long userCount;
	
	
	
	
	/**
	 * 点击率
	 */
	public final static byte TYPE_CLICK = 1;
	
	/**
	 * 转换率
	 */
	public final static byte TYPE_TRANSFORM = 2;
	
	//若TYPE为1，取值 1电、2水、3燃气、4话费、5停车费、6物业费、7生活秘籍、8邀约 9报修
	
	/**
	 * 电
	 */
	public final static long MENU_ELECTRIC = 1;
	
	/**
	 * 水
	 */
	public final static long MENU_WATER = 2;
	
	/**
	 * 燃气
	 */
	public final static long MENU_GAS = 3;
	
	/**
	 * 话费
	 */
	public final static long MENU_TEL_FEE = 4;
	
	/**
	 * 停车费
	 */
	public final static long MENU_CAR_PARK = 5;
	
	/**
	 * 物业费
	 */
	public final static long MENU_PROPERTY_CHARGES = 6;
	
	/**
	 * 生活秘籍
	 */
	public final static long MENU_LIVE_CHEATS = 7;
	
	/**
	 * 邀约
	 */
	public final static long MENU_INVITATION = 8;
	
	/**
	 * 保修
	 */
	public final static long MENU_REPAIR = 9;
	
	
	
	/**
	 * 获取点击类型
	 * @param _Type
	 * @return
	 */
	public String getTypeName(Byte _Type) {
		if (_Type == AppClickStatisticsVo.TYPE_CLICK) {
			return "点击率";
		}
		if (_Type == AppClickStatisticsVo.TYPE_TRANSFORM) {
			return "转换率";
		}

		return String.valueOf(_Type);
	}
	
	/**
	 * 获取点击类型
	 * @param _Type
	 * @return
	 */
	public String getMenuName(long _menuType) {
		if (_menuType == AppClickStatisticsVo.MENU_ELECTRIC) {
			return "电费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_WATER) {
			return "水费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_GAS) {
			return "燃气费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_TEL_FEE) {
			return "话费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_CAR_PARK) {
			return "停车费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_PROPERTY_CHARGES) {
			return "物业费";
		}
		if (_menuType == AppClickStatisticsVo.MENU_LIVE_CHEATS) {
			return "生活秘籍";
		}
		if (_menuType == AppClickStatisticsVo.MENU_INVITATION) {
			return "邀约";
		}
		if (_menuType == AppClickStatisticsVo.MENU_REPAIR) {
			return "报修";
		}
		return String.valueOf(_menuType);
	}

	
	public Byte getType() {
		return type;
	}

	
	public void setType(Byte type) {
		this.type = type;
	}

	
	public Long getTypeId() {
		return typeId;
	}

	
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	
	public String getTypeName() {
		return typeName;
	}

	
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	
	public String getMenuName() {
		return menuName;
	}

	
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	
	public Long getCounts() {
		return counts;
	}

	
	public void setCounts(Long counts) {
		this.counts = counts;
	}

	
	public Long getUserCount() {
		return userCount;
	}

	
	public void setUserCount(Long userCount) {
		this.userCount = userCount;
	}
	
}
