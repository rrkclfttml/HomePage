<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="guest.GuestDAO"/>

<%
	List<GuestDTO> list=dao.list();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(gno){
	var url="./read.jsp";
	url=url+="?gno="+gno;
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br> 
 
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./'>
  <TABLE>
  	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>grpno</th>
			<th>indent</th>
			<th>ansnum</th>
		</tr>
		</thead>
   <% if(list.size()==0){ %>
   <tbody>
   <tr>
   	 <td colspan="7">등록된 방명록이 없습니다.</td>
   </tr>
   </tbody>
   <%}else{
	   for(int i=0;i<list.size();i++){
		   GuestDTO dto=list.get(i);
	   
   %>
   <tbody>
   <tr>
   	  <td><%=dto.getGno() %></td>
   	  <td><div style="text-align:left; padding-left: 10px;">
   	  <%
   	  	for(int r=0;r<dto.getIndent();r++){
   	  		out.print("&nbsp; &nbsp;");
   	  	}if(dto.getIndent()>0){
   	  		out.print("<img src='../images/re.jpg'>");
   	  	}
   	  %>
   	  <a href="javascript:read('<%=dto.getGno()%>')"><%=dto.getTitle()%></a></td>
   	<td><%=dto.getWdate()%></td>
	<td><%=dto.getViewcnt()%></td>
	<td><%=dto.getGrpno()%></td>
	<td><%=dto.getIndent()%></td>
	<td><%=dto.getAnsnum()%></td>
   </tr>
   </tbody>
   <%
	   }
   }
   %>   
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록' onclick="location.href='./createForm.jsp'">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

