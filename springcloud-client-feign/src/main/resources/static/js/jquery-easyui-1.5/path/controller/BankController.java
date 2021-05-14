package com.jk.lzy.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jk.lzy.entity.BankEntity;
import com.jk.lzy.entity.MongodbEntity;
import com.jk.lzy.entity.UserEntity;
import com.jk.lzy.service.BankService;
import com.jk.lzy.utils.CheckImgUtil;

/**
 * 
 * <pre>项目名称：jk_bank_lzy    
 * 类名称：BankController    
 * 类描述：    
 * 创建人：梁展艺
 * 创建时间：2021年3月13日 下午8:06:25    
 * 修改人：梁展艺
 * 修改时间：2021年3月13日 下午8:06:25    
 * 修改备注：       
 * @version </pre>
 */
@Controller
@RequestMapping("bank")
public class BankController {

	@Autowired
	private BankService bankService;
	
	// 登录
		@RequestMapping("login")
		@ResponseBody
		public String login(UserEntity user,HttpSession session){
			return bankService.login(user,session);
		}
		// 验证码
			@RequestMapping("yanzheng")
			@ResponseBody
			public void yanzheng(HttpServletRequest request,HttpServletResponse response){
				CheckImgUtil.buildCheckImg(request, response);
		}
		
	// Oral 分页查询
		@RequestMapping("getquary")
		@ResponseBody
		public HashMap<String, Object> getquary(Integer page,Integer rows,BankEntity bank){
			
			return bankService.getquary(page,rows,bank);
		}
		@RequestMapping("addinsert")
		@ResponseBody
		public String addinsert(MongodbEntity<Date> mon){
			return bankService.addinsert(mon);
		}
		// Mongodb 分页查询
		@RequestMapping("getMongodbQuery")
		@ResponseBody
		public HashMap<String, Object> getMongodbQuery(Integer page,Integer rows,MongodbEntity<Date> mon){
			return bankService.getMongodbQuery(page,rows,mon);
		}
		@RequestMapping("importData")
		public void importData(MultipartFile filename,HttpServletRequest request,HttpServletResponse response){
			bankService.importData( filename, request, response);
		}
		//导出
		@RequestMapping("daobook")
		public void exportMusic(HttpServletResponse response ) {
			//List<MusicBean> list = musicService.findMusic();//mongodb //第一步
			List<MongodbEntity> list = bankService.lookBook();//Oracle //第一步
			//poi导出
			//1、创建excel工作薄
			XSSFWorkbook workbook = new XSSFWorkbook();
			
			//2、创建sheet页
			XSSFSheet sheet = workbook.createSheet("图书信息");//第二步sheet 页
			
			//3、创建行：标题、下标从0开始
			String[] title = {"名称","数量","价格"};   //第三步 导出数据的表头
			XSSFRow row = sheet.createRow(0);
			//给第一行的第一个单元格赋值
			/*row.createCell(0).setCellValue("用户名");
			row.createCell(1).setCellValue("年龄");
			row.createCell(2).setCellValue("性别");
			row.createCell(3).setCellValue("密码");*/
			
			
			for (int i = 0; i < title.length; i++) {
				row.createCell(i).setCellValue(title[i]);
			}
			//4、填充数据
			for (int i = 0; i < list.size(); i++) {
				//获取对象
				MongodbEntity<Date> look = list.get(i);
				
				//创建行
				XSSFRow row1 = sheet.createRow(i+1);//1、2、3...
				//创建列、创建单元格
				row1.createCell(0).setCellValue(look.getZhuanZhangUser());  //第四步 给单元格赋值 下标从0开始
				row1.createCell(1).setCellValue(look.getMoney());
				row1.createCell(2).setCellValue(look.getCode());
				row1.createCell(3).setCellValue(look.getShoukuanUser());
				row1.createCell(4).setCellValue(look.getSkCode());
				row1.createCell(5).setCellValue(look.getCreateDate());
			}
			XSSFRow row1 = sheet.createRow(list.size()+1);
			row1.createCell(0).setCellValue("总价");
			row1.createCell(6).setCellValue(353);
			try {
				//下载
				//设置Content-Disposition :attchment
				response.setHeader("Content-Disposition", "attchment;filename="+URLEncoder.encode("图书信息.xlsx", "utf-8")); //第五步 设置导出文件名   
				ServletOutputStream outputStream = response.getOutputStream();//获取输出流
				workbook.write(outputStream);
				outputStream.close();//关闭资源
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
		}
		//批量删除
		@RequestMapping("delAll")
		@ResponseBody
		public void delAll(String [] id){
			bankService.delAll(id);
		}
}	
