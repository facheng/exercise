package com.dt.tarmag.vo;

public class Tree {

   private String  id;//节点
   private String pId;//父节点
   private String name;//节点名称
   private String open;//是否展开
   private byte valid;
   private boolean checked;
   

   public final static byte VALID_N = 0;
   public final static byte VALID_Y = 1;
   
   
   
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOpen() {
		return open;
	}
	public void setOpen(String open) {
		this.open = open;
	}
	public boolean getChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public byte getValid() {
		return valid;
	}
	public void setValid(byte valid) {
		this.valid = valid;
	}
	
	
	
	
	public int hashCode(){
		return id.hashCode();
	}
	
	public boolean equals(Object obj) {
		if(!(obj instanceof Tree)) return false;
		
		Tree t = (Tree) obj;
		return this.getId().equals(t.getId());
	}
}
