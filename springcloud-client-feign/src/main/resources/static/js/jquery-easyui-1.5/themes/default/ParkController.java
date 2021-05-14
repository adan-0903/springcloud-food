package com.jk.lzy.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jk.lzy.entity.ParkEntity;
import com.jk.lzy.entity.TreeEntity;
import com.jk.lzy.entity.UserEntity;
import com.jk.lzy.service.ParkService;
import com.jk.lzy.utils.CheckImgUtil;
import com.jk.lzy.utils.ImgFileUtil;

@Controller
@RequestMapping("park")
public class ParkController {
	@Autowired
	private ParkService parkService;
	// 登录页面
	@RequestMapping("login")
	@ResponseBody
	public String login(UserEntity user,HttpSession session){
		return parkService.login(user,session);
	}
	// 验证码
	@RequestMapping("yanzheng")
	@ResponseBody
	public void yanzheng(HttpServletRequest request,HttpServletResponse response){
		CheckImgUtil.buildCheckImg(request, response);
	}
	// 递归树
	@RequestMapping("tree")
	@ResponseBody
	public List<TreeEntity> tree(){
		return parkService.tree();
	}
	// 分页查询
	@RequestMapping("getquary")
	@ResponseBody
	public HashMap<String, Object> getquary(ParkEntity park,Integer page,Integer rows){
		return parkService.getquary(park,page,rows);
	}
	// 下拉列表框
	@RequestMapping("xiala")
	@ResponseBody
	public List<ParkEntity> xiala(){
		return parkService.xiala();
	}
	// 新增 
	@RequestMapping("addinsert")
	@ResponseBody
	public String addinsert(ParkEntity park){
		return parkService.addinsert(park);
	}
	// 修改 回显 
	@RequestMapping("gethuixian")
	@ResponseBody
	public ParkEntity gethuixian(Integer id){
		return parkService.gethuixian(id);
	}
	// 删除 
	@RequestMapping("deleteUser")
	@ResponseBody
	public void deleteUser(Integer [] ids){
		parkService.deleteUser(ids);
	}
	// 图片 
	@RequestMapping("uploadfile")
	@ResponseBody
	public String uploadfile(MultipartFile imgfile,HttpServletRequest request) throws IllegalStateException, IOException{
		return ImgFileUtil.uploadfile(imgfile, request);
	}
}
