package com.jk.lzy.service.Impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jk.lzy.dao.BankDao;
import com.jk.lzy.entity.BankEntity;
import com.jk.lzy.entity.MongodbEntity;
import com.jk.lzy.entity.UserEntity;
import com.jk.lzy.service.BankService;
import com.jk.lzy.utils.PoiUtil;
/**
 * 
 * <pre>项目名称：jk_bank_lzy    
 * 类名称：BankServiceImpl    
 * 类描述：    
 * 创建人：梁展艺
 * 创建时间：2021年3月13日 下午8:08:58    
 * 修改人：梁展艺
 * 修改时间：2021年3月13日 下午8:08:58    
 * 修改备注：       
 * @version </pre>
 */
@Service
public class BankServiceImpl implements BankService {
	@Autowired
	private BankDao bankDao;
	@Autowired
	private MongoTemplate mongoTemplate;
	// 登录
		@Override
		public String login(UserEntity user, HttpSession session) {
			String code = (String) session.getAttribute("checkcode");
			if (!user.getUseryan().equalsIgnoreCase(code)) {
				return "验证码不正确";
			}
			UserEntity user1 = bankDao.login(user.getUser_name());
			if (user1 == null) {
				return "账号不存在";
			}
			if (!user.getUser_password().equals(user1.getUser_password())) {
				return "密码不正确";
			}
			session.setAttribute("user", user1);
			return "登录成功";
		}
		// Oral 分页查询
		@Override
		public HashMap<String, Object> getquary(Integer page, Integer rows, BankEntity bank) {
			Integer start = (page-1) * rows+1;
			Integer end = page * rows;
			Integer count = bankDao.quaryCount(bank);
			List<BankEntity> list = bankDao.getquary(start,end,bank);
			HashMap<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows",list);
			return map;
		}
		@Override
		public String addinsert(MongodbEntity<Date> mon) {
			if (!mon.getZhuanZhangUser().equals(mon.getUserer())) {
				return "当前用户不存在";
			}
			mon.setCreateDate(new Date());
			mongoTemplate.save(mon);
			return "成功";
		}
		// Mongodb 分页查询
		@Override
		public HashMap<String, Object> getMongodbQuery(Integer page, Integer rows, MongodbEntity<Date> mon) {
			Query query = new Query();
			Integer start = (page-1) * rows;
			if (StringUtils.isNotEmpty(mon.getZhuanZhangUser())) {
				query.addCriteria(Criteria.where("ZhuanZhangUser").is(mon.getZhuanZhangUser()));
			}
			if(StringUtils.isNotEmpty(mon.getStartprice()) && StringUtils.isNotEmpty(mon.getEndprice())){
				query.addCriteria(Criteria.where("money").gte(mon.getStartprice()).lte(mon.getEndprice()));
				
			}else{
				
				if(StringUtils.isNotEmpty(mon.getStartprice())){
					query.addCriteria(Criteria.where("price").gte(mon.getStartprice()));
					
				}
				if(StringUtils.isNotEmpty(mon.getEndprice())){
					query.addCriteria(Criteria.where("price").lte(mon.getEndprice()));
					
				}
			}
			long count = mongoTemplate.count(query, MongodbEntity.class);
			query.skip(start).limit(rows);
			List<MongodbEntity> list = mongoTemplate.find(query, MongodbEntity.class);
			HashMap<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		}
		//导入
		@Override
		public void importData(MultipartFile filename, HttpServletRequest request, HttpServletResponse response) {
			//注意，不需要id，不需要id，不需要id，不然导入的时候很麻烦，会报id冲突。
			String[] arr = {"zhuanZhangUser","money","code","shoukuanUser","skCode","createDate"};
			List<MongodbEntity<Date>> list = PoiUtil.importData(filename, arr,MongodbEntity.class);
			for (MongodbEntity<Date> mongodbEntity : list) {
				mongodbEntity.setCreateDate(new Date());
				mongoTemplate.save(mongodbEntity);
			}
		}
		// 导出
		@Override
		public List<MongodbEntity> lookBook() {
			Query query = new Query();
			List<MongodbEntity> list = mongoTemplate.find(query, MongodbEntity.class);
			return list;
		}
		//删除
		@Override
		public void delAll(String[] id) {
			Query query = new Query();
				query.addCriteria(Criteria.where("id").in(id));
				mongoTemplate.remove(query, MongodbEntity.class);
		}
}	
