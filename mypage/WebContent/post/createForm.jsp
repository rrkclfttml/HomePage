<%@ page contentType="text/html; charset=UTF-8" %> 
<%    request.setCharacterEncoding("utf-8");
        String root = request.getContextPath();
%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
.content {
	font-size: 24px;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
	margin: 0 auto; /* 가운데 정렬 */
}
TABLE { /*태그 슬렉터*/
	margin: 0 auto; /* 테이블 가운데 정렬 */
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
}

TH {
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	color: #FFFFFF; /* 글자 색 */
	background-color: #666666; /* 배경 색 */
	padding: 5px; /* 셀 내부 간격 */
}

td {
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
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
h2{
	margin: 20px auto;
}
</style> 

<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
  </script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="container"></DIV>
<h2>글 등록</h2>
 <br>
<FORM name='frm' method='POST' action='./createProc.jsp'
		enctype='multipart/form-data'>
  <TABLE class="table table-bordered">
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="pname"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea row="35" cols="50" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd" required></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="filename" multiple></TD>
    </TR>
  </TABLE>
  <br>
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 <br><br><br>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

