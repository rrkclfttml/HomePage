<%@ page contentType="text/html; charset=UTF-8" %> 
<%@include file="../ssi/ssi.jsp" %>
<%
	//쿠키설정
	String c_id="";
	String c_id_val="";
	
	Cookie[] cookies=request.getCookies();
	Cookie cookie=null;
	
	if(cookies!=null){
		for(int i=0;i<cookies.length;i++){
			cookie=cookies[i];
			
			if(cookie.getName().equals("c_id")){
				c_id=cookie.getValue();
			}else if(cookie.getName().equals("c_id_val")){
				c_id_val=cookie.getValue();
			}
		}
	}


%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 

<style type="text/css">
.title{
font-size: 28px;
	text-align: center;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 27%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/}

TABLE { /*태그 슬렉터*/
	margin: 0 auto; /* 테이블 가운데 정렬 */
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
	border-width: 2px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
	
}

TH {
	font-size: 20px;
	border-color: #000000; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	color: #000000; /* 글자 색 */
	background-color: #FFFFFF; /* 배경 색 */
	padding: 10px; /* 셀 내부 간격 */
}

td {
	border-color: #000000; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	color: #000000; /* 글자 색 */
	background-color: #FFFFFF; /* 배경 색 */
	padding: 5px; /* 셀 내부 간격 */
}
.bottom {
	margin: 20px auto;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
}

</style>

</head> 
<body leftmargin="0" topmargin="0">
	<jsp:include page="/menu/top.jsp" flush="false" />
	
<br><br><br>	
<div class="title">로그인</div>
<form name='frm' method='post' action='<%=root%>/member/loginProc.jsp'>
<table>
	<tr>
	<th>I D</th>
	<td><input type="text" name="id" value='<%=c_id_val %>'>
		<%
		if(c_id.equals("Y")){
		%>
		<input type='checkbox' name='c_id' value='Y' checked='checked'> 
		
		
		<%
		}else{
		%>
		<input type='checkbox' name='c_id' value='Y'> ID 저장<!-- <div style= "font-size:12px"> -->
		
		<%} %>
	</td>
	</tr>
	
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="passwd"></td>
	</tr>		
</table>

<div class='bottom'>
	<input type='submit' value='로그인'>
	<input type='button' value='회원가입' onclick="location.href='agreement.jsp'">
</div>
</form>
<br><br><br>
<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
</html> 