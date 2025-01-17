
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

#mainDiv {
	width: 72%;
	margin: 0 auto;
	color: #00282e;
	text-align: center;
}

#mainDiv>h1 {
	margin-bottom: 30px;
	text-align: left;
}

#banner {width:100%;}

#searchDiv {width:100%; text-align:right; margin:20px 0px;}

select, option, input {font-family: "TmoneyRoundWindRegular";}

#bottomdiv {
	width: 100%;
	height: 50px;
	margin: 10px 0px;
}

#count {
	font-size: 0.7em;
	color: #f5ebe3;
	text-align: left;
	float: left;
}

#count:hover {
	color: #efcac3;
}

#buttonMenu {
	float: right;
}

#list ul, #list li {
	margin: 0;
	padding: 0;
	list-style: none;
}

#list {
	width: 100%;
	height: 450px;
}

#adminboardList>li {
	float: left;
	width: 9%;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #f5ebe3;
}

#adminboardList>li:nth-child(7n+3) {
	width: 50%;
	text-align: left;
}

#adminboardList>li:nth-child(3) {
	width: 50%;
	text-align: center;
}

#adminboardList>li:nth-child(7n+1) {
	width: 5%;
}

#userboardList>li {
	float: left;
	width: 11.25%;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #f5ebe3;
}

#userboardList>li:nth-child(6n+3) {
	width: 50%;
	text-align: left;
}

#userboardList>li:nth-child(3) {
	width: 50%;
	text-align: center;
}

#userboardList>li:nth-child(6n+1) {
	width: 5%;
}

.wordCut {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.wordCut a:hover {
	color: #fd7d73;
}

#popup0 {
	color: #f5ebe3;
}

#popup0:hover {
	color: #81bbaf;
}

#popup1 {
	color: #fd7d73;
}

.button {
	background-color: #fd7d73;
	border: none;
	color: #f5ebe3;
	padding: 10px 20px;
	margin: 10px 0px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	border-radius: 12px;
	transition-duration: 0.4s;
	font-size: 13px;
	width: 70px;
	text-align: center;
}

.button:hover {
	color: #0e595f;
}

ul.pagination {
	display: inline-block;
	padding: 0;
	margin: 0;
}

ul.pagination li {
	display: inline;
}

ul.pagination li a {
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	border-radius: 5px;
}

ul.pagination li a.active {
	background-color: #fd7d73;
	color: #f5ebe3;
	border-radius: 5px;
}

ul.pagination li a:hover:not(.active) {
	background-color: #f5ebe3;
}
</style>

<script>
   $(()=>{
	   //전체선택
      $('#allChk').on('change',function(){
    	  $('#adminboardList input[type=checkbox]').prop('checked',$('#allChk').prop('checked'));
    	  $('#userboardList input[type=checkbox]').prop('checked',$('#allChk').prop('checked'));
      });
   });
   
</script>

<div id="mainDiv">
	<h1>공지사항</h1>
	<img src="imgs/banner/notice.jpg" id="banner"/>
	
	<!-- 검색 -->
	<div id="searchDiv">
		<div>
			<form method="get" id="searchFrm" name="searchFrm" action="/wherewego/noticeList">
				<select name="searchKey">
					<option value="title">제목</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchWord" id="searchWord" placeholder="검색어 입력" required/>
				<input type="submit" value="검색" class="button"/>
			</form>
		</div>
	</div>

	<div id="list">
		<!-- 관리자 모드 -->
		<c:if test="${logid=='admin'}">
			<ul id="adminboardList">
				<li><input type="checkbox" id="allChk"></li>
				<li><b>No.</b></li>
				<li class="wordCut"><b>제목</b></li>
				<li><b>작성일</b></li>
				<li><b>조회수</b></li>
				<li><b>첨부파일</b></li>
				<li><b>팝업</b></li>

				<c:forEach var="vo" items="${list}">
					<li><input type="checkbox" name="chk" value="${vo.n_num}" /></li>
					<li>${vo.n_num }</li>
					<li class="wordCut"><a
						href="/wherewego/noticeView?n_num=${vo.n_num}&nowPage=${pVo.nowPage}">${vo.title}</a></li>
					<li>${vo.writedate }</li>
					<li>${vo.hit }</li>
					<li><c:if test="${vo.photo==null}">
							<img src="imgs/disk0.png" />
						</c:if> <c:if test="${vo.photo!=null}">
							<a href="upload/noticefile/${vo.photo }" download><img src="imgs/disk.png" /></a>
						</c:if></li>
					<li>
						<form method="post" action="/wherewego/noticePopup" name="Frm${vo.n_num }">	
							<input type="hidden" name="n_num" id="n_num" value="${vo.n_num}">
							<input type="hidden" name="pop" id="pop" value="${vo.pop}">
							<input type="hidden" name="photo" id="photo" value="${vo.photo}">
							<c:if test="${vo.pop==1}">
								<a href="javascript:document.Frm${vo.n_num }.submit();" id="popup1">on</a>
							</c:if>
							<c:if test="${vo.pop==0}">
								<a href="javascript:document.Frm${vo.n_num }.submit();" id="popup0">on</a>
							</c:if>
						</form>
					</li>
				</c:forEach>
			</ul>
		</c:if>

		<!-- 일반 사용자 모드 -->
		<c:if test="${logid!='admin'}">
			<ul id="userboardList">
				<li><input type="checkbox" id="allChk"></li>
				<li>No.</li>
				<li class="wordCut">제목</li>
				<li>작성일</li>
				<li>조회수</li>
				<li>첨부파일</li>

				<c:forEach var="vo" items="${list}">
					<li><input type="checkbox" name="chk" value="${vo.n_num}" /></li>
					<li>${vo.n_num }</li>
					<li class="wordCut"><a href="/wherewego/noticeView?n_num=${vo.n_num}&nowPage=${pVo.nowPage}">${vo.title}</a></li>
					<li>${vo.writedate }</li>
					<li>${vo.hit }</li>
					<li><c:if test="${vo.photo==null}">
							<img src="imgs/disk0.png" />
						</c:if> <c:if test="${vo.photo!=null}">
							<a href="upload/noticefile/${vo.photo }" download><img src="imgs/disk.png" /></a>
						</c:if></li>
				</c:forEach>
			</ul>
		</c:if>
	</div>


	<!-- 버튼 -->
	<c:if test="${logid=='admin'}">
		<div id="bottomdiv">
			<div id="count">
				<div>총 레코드 수 : ${pVo.totalRecord }</div>
				<div>현재페이지/총페이지수 : ${pVo.nowPage}/${pVo.totalPage}</div>
			</div>

			<div id="buttonMenu">
				<a class="button" href="noticewrite">작성</a>
				<a class="button" href="#">삭제</a>
			</div>
		</div>
	</c:if>

	<!-- 페이징 -->
	<div id="paging">
		<ul class="pagination">
			<!-- 이전페이지 -->
			<c:if test="${pVo.nowPage>1}">
				<li class='page-item'><a
					href="/wherewego/noticeList?nowPage=${pVo.nowPage-1}"
					class='page-link'>«</a></li>
			</c:if>

			<c:if test="${pVo.nowPage==1}">
				<li class='page-item'><a href='#'>«</a></li>
			</c:if>

			<!-- 시작페이지부터 5개의 페이지 출력 -->
			<c:forEach var="i" begin="${pVo.startPage}"
				end="${pVo.startPage+pVo.onePageNumberCount-1}">

				<c:if test="${i<=pVo.totalPage}">

					<c:if test="${i==pVo.nowPage}">
						<li><a class="active"
							href="/wherewego/noticeList?nowPage=${i}">${i}</a>
					</c:if>

					<c:if test="${i!=pVo.nowPage}">
						<li><a href="/wherewego/noticeList?nowPage=${i}">${i}</a>
					</c:if>
				</c:if>
			</c:forEach>

			<!-- 다음페이지-->
			<c:if test="${pVo.nowPage<pVo.totalPage}">
				<li class='page-item'><a
					href="/wherewego/noticeList?nowPage=${pVo.nowPage+1}">»</a></li>
			</c:if>

			<c:if test="${pVo.nowPage==pVo.totalPage}">
				<li class='page-item'><a href='#'>»</a></li>
			</c:if>
		</ul>
	</div>
</div>