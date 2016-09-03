<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.farmer.huan.DBConfig" %>
<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String rownum = "",
				idx = "",
				id = "",
				title = "",
				regdate = "";
	
	String dbID = DBConfig.DB_ID;
	String dbPW = DBConfig.DB_PW;
	
	int count = 0;
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl",dbID,dbPW);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select rownum,idx,id,title,regdate from fh_tb_qna order by idx desc");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/layout.css">
<title>Project BARISTA - QnA</title>
</head>
<body>


	
	<div id="test" width="500px">
		<!--  Path : //getServletContext().getRealPath("/")  </h3> -->
		<p>
			<form method="post" action="../../views/login.jsp">
				<textblock>아이디:</textblock>
			 	<input id="login_id" name="id" type="text" value="" /> <br/>
			 	<textblock>비밀번호:</textblock>
			 	<input id="login_pw" name="pw" type="text" value="" /> <br/>
			 	<input type="submit" value="로그인" />
		 	</form>
			<%
				Object session_id = session.getAttribute("session_id");
				String sid = (String) session_id;
				if(sid == "" || sid == null) {
					out.println("session null");
				} else {
					out.println("session_id: " + session_id);
				}
			%>
			</p>
	 	<p></p>
	 	<input type="button" value="regist.jsp" onclick="location.href='../../views/regist.jsp'"/>
	 	<input type="button" value="memberlist.jsp" onclick="location.href='../../views/memberlist.jsp'"/>
	 	<input type="button" value="insert.jsp" onclick="location.href='../../views/insert.jsp'"/>
	 	<p></p>
	 	
	</div>
	<div class="wrap">
		<div class="header">
			<div>
				<div class="huanImg">
					<div class="login">
						<div>
							<a href="#">로그인</a> | 
							<a href="#">회원가입</a>
						</div>
					</div>
					<img src="../../img/FamHuan.png" />
				</div>
			</div>
			<div class="topMenu">
				<ul class="top_nav">
					<li><a href="#">메인</a></li>
					<li><a href="#">게시판</a></li>
					<li><a href="#">커피가이드</a></li>
					<li><a href="#">회원</a></li>
				</ul>
			</div>
		</div>
		<div class="contentWrap">
			<div class="listWrap">
				<div class="left">
					<ul>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">게시판</a></li>
						<li><a href="http://localhost:8080/HuanProject/root/board/qna.jsp">QnA</a></li>
						<li><a href="http://localhost:8080/HuanProject/root/board/guestbook.jsp">방명록</a></li>
					</ul>
				</div>
				<div class="content">
					<div class="contentNav">게시판 &gt; QnA</div>
					<div class="list">
						<table>
							<colgroup>
								<col width="80px" />
								<col width="*" />
								<col width="80px" />
								<col width="80px" />
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
<%
	if(rs != null){
		while(rs.next()){
			idx = rs.getString("idx");
			title = rs.getString("title");
			id = rs.getString("id");
			regdate = rs.getString("regdate").substring(0,10);
%>
								<tr>
									<td><%=idx%></td>
									<td class="tl pl5"><a href="http://localhost:8080/HuanProject/root/board/qnaRead.jsp?qno=<%=idx%>"><%=title%></a></td>
									<td><%=id%></td>
									<td><%=regdate%></td>
								</tr>

<%			count++;
			if(count >= 10){
				count = 0;
				break;
			}
			
		}//end while
	}//end if
%>
							</tbody>
						</table>
						<div>
							<input type = "button" value = "CREATE" onclick = "location.href='./qnaCreate.jsp'">
						</div>
						<div class="paging">
							<a href="#" class="prev"><img src="../../img/btn_prev.gif" /></a>
							<strong><span>1</span></strong>
							<a href="http://localhost:8080/HuanProject/root/board/qna.jsp?pagenum=2"><span>2</span></a>
							<a href="http://localhost:8080/HuanProject/root/board/qna.jsp?pagenum=3"><span>3</span></a>
							<a href="http://localhost:8080/HuanProject/root/board/qna.jsp?pagenum=4"><span>4</span></a>
							<a href="http://localhost:8080/HuanProject/root/board/qna.jsp?pagenum=5"><span>5</span></a>
							<a href="#" class="next"><img src="../../img/btn_next.gif" /></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="footer"><span>copy right</span></div>
	</div>
	
	

<%
	}catch(SQLException e){
		System.out.println(e);		
	}catch(Exception e){
		System.out.println(e);
	}finally{
		if(rs != null){
			try{rs.close();}
			catch(SQLException e){}
		}if(stmt != null){
			try{stmt.close();}
			catch(SQLException e){}
		}if(conn != null){
			try{conn.close();}
			catch(SQLException e){}
		}
	}
%>
</body>
</html>