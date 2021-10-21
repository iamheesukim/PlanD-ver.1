package com.bit5.wherewego.place;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit5.wherewego.notice.PagingVO;

@Controller
public class PlaceController {
	SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//장소관리 목록
		@RequestMapping("/placeList")
		public ModelAndView list(PagingVO pVo) {

			ModelAndView mav = new ModelAndView();
			PlaceDAOImp dao = sqlSession.getMapper(PlaceDAOImp.class);
			PlaceDAOImp dao2 = sqlSession.getMapper(PlaceDAOImp.class);
			
			int total = dao2.totalRecordCount(pVo);
			pVo.setTotalRecord(total);
			
			int num1 = pVo.getOnePageRecord() * pVo.getNowPage();
			int num2;
			
			int lastPageRecord = pVo.getTotalRecord() % pVo.getOnePageRecord();
			if (pVo.getTotalPage() == pVo.getNowPage() && lastPageRecord != 0) {
				num2 = lastPageRecord;
			} else {
				num2 = pVo.getOnePageRecord();
			}
			
			mav.addObject("list",dao.placeAllSelect(num1,num2));
			mav.addObject("pVo",pVo);
			mav.setViewName("place/placeList");

			return mav;
		}
		

}
