package com.jk.lzy.service.Impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.lzy.dao.ParkDao;
import com.jk.lzy.entity.ParkEntity;
import com.jk.lzy.entity.TreeEntity;
import com.jk.lzy.entity.UserEntity;
import com.jk.lzy.service.ParkService;
@Service
public class ParkServiceImpl implements ParkService {
	@Autowired
	private ParkDao parkDao;
	// 登录页面
	@Override
	public String login(UserEntity user, HttpSession session) {
		String code = (String) session.getAttribute("checkcode");
		if (!user.getUseryan().equalsIgnoreCase(code)) {
			return "验证码不正确";
		}
		UserEntity user1 = parkDao.login(user.getUsername());
		if (user1 == null) {
			return "账号不存在";
		}
		if (!user.getPassword().equals(user1.getPassword())) {
			return "密码不正确";
		}
		session.setAttribute("user", user1);
		return "登录成功";
	}
	// 递归树
	@Override
	public List<TreeEntity> tree() {
		Integer pid = 0;
		List<TreeEntity> list = parkDao.tree(pid);
		for (TreeEntity treeEntity : list) {
			List<TreeEntity> list2 = parkDao.tree(treeEntity.getId());
			treeEntity.setChildren(list2);
		}
		return list;
	}
	// 分页查询
	@Override
	public HashMap<String, Object> getquary(ParkEntity park, Integer page, Integer rows) {
		Integer count = parkDao.quaryCount(park);
		Integer start = (page-1) * rows+1;
		Integer end = page * rows;
		List<ParkEntity> list = parkDao.getquary(park,start,end);
		HashMap<String, Object> map = new HashMap<>();
		map.put("total", count);
		map.put("rows",list);
		return map;
	}
	// 下拉列表框
	@Override
	public List<ParkEntity> xiala() {
		return parkDao.xiala();
	}
	// 新增
	@Override
	public String addinsert(ParkEntity park) {
		if (park.getLotid() == null) {
			String str = "";
			// 新增 小业务 弹窗
			ParkEntity park1 = parkDao.getcha(park);
			if (park1 == null) {
				parkDao.addinsert(park);
				str += "新增成功";
			}else{
				str += "无法新增,该车位以被占用";
			}
			
			return str;
		}else{
			// 修改
			return parkDao.getxiu(park);
		}
		
	}
	//修改 回显 
	@Override
	public ParkEntity gethuixian(Integer id) {
		return parkDao.gethuixian(id);
	}
	// 删除
	@Override
	public void deleteUser(Integer[] ids) {
		for (int i = 0; i < ids.length; i++) {
			parkDao.deleteUser(ids[i]);
		}
	}
	
}
