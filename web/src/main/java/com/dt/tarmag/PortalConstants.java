package com.dt.tarmag;


/**
 * @author wei
 **/
public class PortalConstants extends Constants{

	/**
	 * session中的key(用户的小区ID)
	 */
	public final static String SESSION_USER_UNIT = "sessionUserUnit";

	/**
	 * session中的key(用户的角色ID)
	 */
	public final static String SESSION_USER_ROLE = "sessionUserRole";

	/**
	 * session中的key(当前用户所有的小区)
	 */
	public final static String SESSION_USER_UNIT_LIST = "sessionUserUnitList";

	/**
	 * session中的key(当前用户在当前小区中的所有角色)
	 */
	public final static String SESSION_USER_ROLE_LIST = "sessionUserRoleList";

	/**
	 * session中的key(当前用户有权限的所有菜单)
	 */
	public final static String SESSION_AUTHORIZED_MENUS = "sessionAuthorizedMenus";
	
	/**
	 * session中的key(当前选择的一级菜单Code)
	 */
	public final static String SESSION_FIRST_LEVEL_MENU_CODE = "sessionFirstLevelMenuCode";
	/**
	 * session中的key(当前选择的二级菜单Code)
	 */
	public final static String SESSION_SECOND_LEVEL_MENU_CODE = "sessionSecondLevelMenuCode";
	
}
