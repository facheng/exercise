package com.dt.tarmag.test.other;


public class ArrTest {

	public static void main(String[] args) {
		int []arrs = {0,1,2,3,4,5,6,7,8,9,10,100,23,11};
		System.out.println(OutMaxNUm(arrs,5));
	}
	
	//arrs 要遍历的数组  flagNum需要输出多少个数字
	public static String OutMaxNUm(int [] arrs , int flagNum){
		
		String outStr = "";
		
		//采用冒泡排序
		for(int i = 0 ; i < arrs.length ; i++){
			
			for(int j = i + 1; j < arrs.length ; j++){
				int temp;
				
				if(arrs[i]  < arrs[j]){
					   temp = arrs[i];
					arrs[i] = arrs[j];
					arrs[j] = temp;
				}
			}
		}
		
		for(int i = 0  ; i <= arrs.length - 1; i++){
			outStr += arrs[i] + ",";
		}
		
		return outStr;
	}
}
