<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/> 
<%
	String id=request.getParameter("id");
	boolean	flag=dao.checkId(id);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css">
.title{
font-size: 28px;
	text-align: center;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 30%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/}
	
.content {
	font-size: 24px;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
	margin: 0 auto; /* 가운데 정렬 */
}
.bottom {
	margin: 20px auto;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
}

</style>

<script type="text/javascript">
function use(){
	opener.frm.id.value='<%=id%>';  
	window.close();
}

</script>
</head> 

<body>
 
<DIV class="title">아이디<br>중복 확인</DIV>
 
<div class="content">
입력된 ID: <%=id %><br><br>

<%
	if(flag){
		out.print("중복되어 사용할 수 없습니다.<br><br>");
	}else{
		out.print("사용이 가능합니다.<br><br>");
		out.print("<button onclick='use()'>사용</button>");
	}
%>

</div>
  
  <DIV class='bottom'>
    <input type='button' value='다시시도'  onclick="location.href='id_form.jsp'">
    <input type='button' value='닫기' onclick="window.close()">
  </DIV>

 
 

</body>

</html> 

