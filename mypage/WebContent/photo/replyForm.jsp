<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="photo.PhotoDAO" /> 

<%
int photono = Integer.parseInt(request.getParameter("photono"));
PhotoDTO dto = dao.replyread(photono);

%>
 
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
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./replyProc.jsp'
		enctype="multipart/form-data">
<input type="hidden" name="photono" value="<%=dto.getPhoto()%>">
<input type="hidden" name="grpno" value="<%=dto.getGrpno()%>">
<input type="hidden" name="indent" value="<%=dto.getIndent()%>">
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>">

  <TABLE>
<TR>
      <TH>성명</TH>
      <TD><input type = "text" name = "name"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type = "text" name = "title" value = "<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>사진파일</TH>
      <TD><input type = "file" name = "photo" ></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type = "password" name = "passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='목록' onclick="location.href='list.jsp'">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

