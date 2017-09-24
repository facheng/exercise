package com.dt.tarmag.service;

public interface IResidentUnitService {
	/**
	 * 用户小区绑定
	 */
	void unitBinding_tx(Long unitId,Long residentId);
}
