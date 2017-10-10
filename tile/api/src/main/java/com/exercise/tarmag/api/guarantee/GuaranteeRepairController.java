package com.dt.tarmag.api.guarantee;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IRepairService;

@Controller
@RequestMapping("guarantee/repair")
public class GuaranteeRepairController extends AbstractDtController {

	@Autowired
	private IRepairService repairService;
	
	
	/**
	 * 获取维修人员保修列表
		workerId 当前id
		status 1 进行中 2已完成
		pageNo 页码
	 * @param workerId
	 * @param status
	 * @param pageNo
	 * @return
	 */
	@RequestMapping(value = "repairs", method = GET)
	@ResponseBody
	public MsgResponse repairs(Long workerId,int status, int pageNo) {
		MsgResponse response = null;
		try{
			response = new Success();
			response.put("repairs", this.repairService.repairs(workerId,status,pageNo));
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
	
	/**
	 * 维修人员操作 
	 * @param repairId
	 * @param status 2已拒绝，3已接收，4已签到，5可修，6不可修，7已完成
	 * @param remark
	 */
	@RequestMapping(value = "oper", method = POST)
	@ResponseBody
	public MsgResponse oper(Long workerId, Long repairId,int status, String remark) {
		MsgResponse response = null;
		try{
			this.repairService.oper_tx(workerId, repairId, status, remark);
			response = new Success();
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
	
	/**获取保修图片
	 * @param workerId
	 * @param repairId
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "pictures", method = GET)
	@ResponseBody
	public MsgResponse pictures(Long workerId, Long repairId,int status) {
		MsgResponse response = null;
		try{
			response = new Success("pictures", this.repairService.pictures(workerId, repairId,status));
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
	
	
	/**
	 * 获取评分
	 * @param repairId
	 * @return
	 */
	@RequestMapping(value = "scores", method = GET)
	@ResponseBody
	public MsgResponse scores(Long repairId) {
		MsgResponse response = null;
		try{
			response = new Success("scores", this.repairService.scores(repairId));
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
}
