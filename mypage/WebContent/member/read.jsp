<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>

<%
	String id=request.getParameter("id");
	if(id==null){
		id=(String)session.getAttribute("id");
	}
	MemberDTO dto=dao.read(id);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<script type="text/javascript">
function mupdate(){
	var url="updateForm.jsp";
	url=url+"?id=<%=id%>";
	location.href=url;
}
function updateFile(){
	var url="updateFileForm.jsp";
	url=url+"?id=<%=dto.getId()%>";
	url=url+"&oldfile=<%=dto.getFname()%>";
	location.href=url;
}
function updatePwForm(){
	var url="updatePwForm.jsp";
	url=url+"?id=<%=dto.getId()%>";
	location.href=url;
}
function mdel(){
	var url="deleteForm.jsp";
	url=url+"?id=<%=id%>";
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="title"><%=dto.getMname() %>의 회원정보</DIV>

 <table>
    <TR>
    <td colspan="2" style="text-align:center" >
    <img src="<%=root %>/member/storage/<%=dto.getFname()%>"></td>
    </tr>
    
    <tr>
      <TH>아이디</TH>
      <TD><%=dto.getId() %></TD>
    </TR>
    <tr>
      <TH>성명</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <tr>
      <TH>전화번호</TH>
      <TD><%=dto.getTel() %></TD>
    </TR>
    <tr>
      <TH>이메일</TH>
      <TD><%=dto.getEmail() %></TD>
    </TR>
    <tr>
      <TH>주소</TH>
      <TD><%=dto.getAddress1() %>
      		<%=Utility.checkNull(dto.getAddress2()) %>
      </TD>
    </TR>
    <tr>
      <TH>날짜</TH>
      <TD><%=dto.getMdate() %></TD>
    </TR>
</TABLE>
  
  <DIV class='bottom'>
  	<input type='button' value='회원목록' onclick="location.href='list.jsp'">
    <input type='button' value='정보수정' onclick="mupdate()">
    <input type='button' value='사진수정' onclick="updateFile()">
    <input type='button' value='패스워드 변경' onclick="updatePwForm()">
    <input type='button' value='회원탈퇴' onclick="mdel()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

