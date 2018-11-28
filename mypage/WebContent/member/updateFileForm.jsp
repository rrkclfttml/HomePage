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
<DIV class="title">이미지 수정</DIV>
 
<FORM name='frm' method='POST' action='./updateFileProc.jsp'
		enctype="multipart/form-data">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile")%>">
  <TABLE>
  <TR>
    <td colspan="2" style="text-align:center" >
    <img src="./storage/<%=request.getParameter("oldfile") %>"></td>
    </tr>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="fname"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

