<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/>

 
<%
	String col=Utility.checkNull(request.getParameter("col"));
	String word=Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) word="";
	
	Map map=new HashMap();
	map.put("col",col);
	map.put("word",word);
	
	int nowPage=1;
	int recordPerPage=5;
	
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno=((nowPage-1)*recordPerPage)+1;
	int eno=nowPage*recordPerPage;
	
	map.put("sno",sno);
	map.put("eno",eno);
	
	List<PostDTO> list=dao.list(map);
	
	int totalRecord=dao.total(map);

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

.search {
	font-size: 16px;
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
	width: 45%;
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
</style>

<script type="text/javascript">
function read(postno){
	var url="read.jsp";
	url=url+"?postno="+postno;
	location.href=url;
}
function fileDown(filename){
	var url="<%=root%>/download";
	url=url+"?filename="+filename;
	url=url+"&dir=/post/storage";
	location.href=url;
}

</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <br><br><br>
<h2>목록</h2>
<DIV class="search">
 
<FORM name='frm' method='POST' action='./list.jsp'>
<select name="col">
	<option value="pname" <%if(col.equals("pname")) out.print("selected"); %>>이름</option>
	<option value="title" <%if(col.equals("title")) out.print("selected"); %>>제목</option>
	<option value="content" <%if(col.equals("content")) out.print("selected"); %>>내용</option>
	<option value="total">전체출력</option> 
</select>  

<input type="text" name="word" value="<%=word%>">
<button>검색</button>
<button type="button" onclick="location.href='createForm.jsp'">등록</button>
</FORM>
</div>

<br>
<div class="container">
	<table class="table table-hover">
	<thead>
	<TR>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>성명</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>파일명</TH>
     </TR>
	<thead>
	<%
		if(list.size()==0){
	%>
	<tbody>
	<tr>
	<td colspan="6">
	등록된 글이 없습니다.</td></tr>
	</tbody>
	
	<%
		}else{
			for(int i=0;i<list.size();i++){
				PostDTO dto=list.get(i);
	%>
	<tbody>
		<tr>
		<td><%=dto.getPostno() %></td>
		<td>
		<%
			for(int r=0;r<dto.getIndent();r++){
				out.print("&nbsp;&nbsp");
			}
			if(dto.getIndent()>0)
				out.print("<img src='../imges/re.jpg'>");		
		%>
	<a href="javascript:read('<%=dto.getPostno() %>')"><%=dto.getTitle() %></a>
	
	</td>
	<td><%=dto.getPname() %></td>
	<td><%=dto.getViewent()%></td> 
	<td><%=dto.getWdate() %></td>
	<td>
	<%if(dto.getFilename()!=null){ %>
	&nbsp;
	<a href="javascript:fileDown('<%=dto.getFilename() %>')">
	<img src='../imges/download.png'>&nbsp;<%=dto.getFilename() %></a>
     
     <%
    	}else{
    		out.print(" ");
    }%>
    	</td> 
   	</tr>
	</tbody>
	<%
			}
		}
	
	%>
	</table>
	
	<br>
	<DIV class='bottom'>
    <%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
  </DIV>
	
</div>

 <br><br>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

