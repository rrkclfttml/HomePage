<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>




<%
//검색관련
	String col=Utility.checkNull(request.getParameter("col"));
	String word=Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")){
		word="";
	}

//페이징관련
	int nowPage=1;
	int recordPerPage=5;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}

//DB에서 가져올 번호계산
	int sno=((nowPage-1)*recordPerPage)+1;
	int eno=nowPage*recordPerPage;
	
	Map map=new HashMap();
	map.put("col",col);
	map.put("word",word);
	map.put("sno", sno);
	map.put("eno",eno);
	

//dao빈즈 사용
	List<MemberDTO> list= dao.list(map);
	int totalRecord=dao.total(map);
	String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);

%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
.search{
	text-align:center;
	margin:20px auto;
}
</style>
<script type="text/javascript">
function read(id){
	var url="<%=root%>/member/read.jsp";
	url=url+"?id="+id;
	location.href=url;
}
</script> 
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<br><br>
<div class="search">
 
<FORM name='frm' method='POST' action='./list.jsp'>
<select name="col">
	<option value="id"
	<%if(col.equals("id")) out.print("selected");%>
	>아이디</option>
	<option value="email"
	<%if(col.equals("email")) out.print("selected");%>
	>이메일</option>
	<option value="mname"
	<%if(col.equals("mname")) out.print("selected");%>
	>성명</option>
	<option value="total">전체출력</option>
</select>
<input type="text" name="word" value="<%=word %>">

<button>검색</button>
<button type="button" onclick="location.href='<%=root%>/member/createForm.jsp'">회원가입</button>
</form>
</div>

<div class="container">
<h2><span class="glyphicon glyphicon-th-list"></span>
	회원 목록
</h2>
<%
	for(int i=0;i<list.size();i++){
		MemberDTO dto=list.get(i);
%>
  <TABLE class="table table-hover">
    <TR>
    <td rowspan='5' style="width:20%">
    <img src='<%=root %>/member/storage/<%=dto.getFname() %>' width="250px" height="250px"></td>
      <TH style="width:20%">아이디</TH>
      <TD style="width:55%">
      <a href="javascript:read('<%=dto.getId() %>')"><%=dto.getId() %></a></TD>
    </TR>
    
    <tr>
    	<th>성명</th>
    	<td><%=dto.getMname() %></td>
    </tr>
    <tr>
    	<th>전화번호</th>
    	<td><%=dto.getTel() %></td>
    </tr>
    <tr>
    	<th>이메일</th>
    	<td><%=dto.getEmail() %></td>
    </tr>
    <tr>
    	<th>주소</th>
    	<td>
    		<%=Utility.checkNull(dto.getAddress1()) %>
    		<%=Utility.checkNull(dto.getAddress2()) %>
    	</td>
    </tr>

  </TABLE>
  <br>
  <%} %>
  
  <DIV class='bottom'>
  	<%=paging %>
   </DIV>
</div>

 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 

