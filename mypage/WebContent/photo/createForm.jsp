<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="title">이미지 등록</DIV>
 
<FORM name='frm' method='POST' action='./createProc.jsp'
		enctype="multipart/form-data">
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" ></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="name" ></TD>
    </TR>
    <TR>
      <TH>사진</TH>
      <TD><input type="file" name="photo" ></TD>
    </TR>
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="passwd" ></TD>
    </TR>
  </TABLE>
 
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

