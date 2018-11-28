<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="photo.PhotoDAO"/>
 
<%  
	
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) word="";
	

	int nowPage= 1;
	int recordPerPage = 10;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno = ((nowPage-1)*recordPerPage) +1;
	int eno = nowPage * recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
		
	List<PhotoDTO> list = dao.list(map);
	// 전체 레코드 개수(col,word)
	int totalRecord = dao.total(map); 
	
%>  

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<script type="text/javascript">
function read(photono){
	var url = "read.jsp";
	url += "?photono=" + photono;
	
	location.href = url;
}
function del(photono){
	var url ="deleteForm.jsp";
	url += "?photono=" + photono;
	
	location.href = url;
}

</script> 
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <br><br><br>
 <div class="search" style="text-align:center;">
<form method="post" action="./list.jsp">
<select name="col" >
<option value="name"
<%if(col.equals("name")) out.print("selected"); %>
>성명</option>
<option value="title"
<%if(col.equals("title")) out.print("selected"); %>
>이미지제목</option>
<option value="total">전체출력</option>
</select>
<!-- 입력값 -->
<input type="text" name="word" value="<%=word %>">
<button>검색</button>
<button type="button" onclick="location.href='createForm.jsp'" style="margin:15px auto;">
사진올리기</button>

</FORM>

<h2>
<span class="glyphicon glyphicon-th-large"></span>
이미지 게시판 목록</h2>

  <TABLE class="table table-striped">
    <thead>
    <TR>
      <TH>글번호</TH>
      <TH>이미지제목</TH>
      <TH>글쓴이</TH>
      <TH>등록일</TH>
      <TH>조회수</TH>
      <TH>grpno</TH>
      <TH>indent</TH>
      <TH>ansnum</TH>
      <TH>삭제</TH>
    </TR>
    </thead>
<%
if(list.size()==0){
	
%>
<tbody>
<tr>
<td style="text-align:center" colspan="8"><br><br><br><br>
등록된 사진이 없습니다.<br><br><br><br><br></td>
</tr>
</tbody>
<%
	}else{
	for(int i=0;i<list.size();i++){
		PhotoDTO dto = list.get(i);
%>
	<tbody>
    <TR>
      <TD><br><br><%=dto.getPhotono() %></TD>
      <TD><%
      for(int r=0;r<dto.getIndent();r++){
    	  out.print("&nbsp;");  // &nbsp; 한칸
      }
      if(dto.getIndent()>0){
    	  out.print("<img src='../images/re.jpg'>"); 
      } 
      %><a href="javascript:read('<%=dto.getPhotono() %>')">
      <img src="./storage/<%=dto.getPhoto() %>" style="width:150px;height:150px;">
      <%=dto.getTitle() %></a>      
      </TD>
      
      <TD><br><br><%=dto.getName() %></TD>
      <TD><br><br><%=dto.getMdate() %></TD>
      <TD><br><br><%=dto.getViewcnt() %></TD>
      <TD><br><br><%=dto.getGrpno() %></TD>
      <TD><br><br><%=dto.getIndent() %></TD>
      <TD><br><br><%=dto.getAnsnum() %>
      </TD>
      <TD><br><br>
       <input type='button' value='삭제' onclick="del(<%=dto.getPhotono()%>)">
      </TD>
    </TR>
    </tbody>
<%
	}
}
%>

</TABLE>

 <DIV style="text-align:center" class='bottom' >
  	<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
  	<br><br>

  
  </DIV>
 
</div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

