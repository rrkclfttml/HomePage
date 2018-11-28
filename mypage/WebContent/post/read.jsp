<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<<jsp:useBean id="dao" class="post.PostDAO"/>

<%
	int postno=Integer.parseInt(request.getParameter("postno"));
	dao.upViewcnt(postno);
	PostDTO dto=dao.read(postno);
	
	String content=dto.getContent();
	content=content.replaceAll("\r\n","<br>");

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
/* 	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */ */
/* 	border-width: 1px; /* 테이블 외곽선 두께 */ */
/* 	border-style: solid; /* 테이블 외곽선 스타일 */ */
/* 	border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */ */
/* 	width: 45%; */
}
.bottom {
	margin: 20px auto;
	text-align: center;
	width: 100%;
	padding: 10px; /* 위 오른쪽 아래 왼쪽 */
}
h2{
	text-align: center;
}
</style>

<script type="text/javascript">
function plist(){
	var url="list.jsp";
	location.href=url;
}
function pupdate(){
// 	var url="passwdCheck.jsp";
<%-- 	url=url+"?postno=<%=dto.getPostno()%>"; --%>
// 	loaction.href=url;
	
	var url="updateForm.jsp";
	url=url+"?postno=<%=dto.getPostno()%>";
	location.href=url;
}
function pdel(){
	var url="deleteForm.jsp";
	url=url+"?postno=<%=postno%>";
	url=url+"&oldfile=<%=dto.getFilename()%>";
	url=url+"&col=<%=request.getParameter("col")%>";
	url=url+"&word=<%=request.getParameter("word")%>";
	url=url+"&nowpage=<%=request.getParameter("nowpage")%>";
	location.href=url;
}
function reply(){
	var url="replyForm.jsp";
	url=url+"?postno=<%=dto.getPostno()%>";
	location.href=url;
}
function fileDown(filename){
	var url="<%=root%>/download";
	url=url+"?filename=<%=dto.getFilename()%>";
	url=url+"&dir=/post/storage";
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br><br>
<DIV class="title"><h2>조회</h2></DIV>
<br>
 
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getPname() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=content %></TD>
    </TR>
    <TR>
      <TH>조회수</TH>
      <TD><%=dto.getViewent() %></TD>
    </TR>
    <TR>
      <TH>등록일</TH>
      <TD><%=dto.getWdate() %></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD>
        <%
		 if(dto.getFilename()!=null){%>
	    <a href="javascript:fileDown()">
	    <img src="../imges/download.png">
	    </a>    
	      (<%=dto.getFilename() %> &nbsp;
           <%=(dto.getFilesize()/1024) %>KB)
           
        <%
        }else{
        	out.print("파일없음");
        }
        %>   
      </TD>
    </TR>
  </TABLE>
  
<br><br>  
  <DIV class='bottom'>
   <input type='button' value='목록' onclick="plist()">
    <input type='button' value='등록' onclick="location.href='createForm.jsp'">
    <input type='button' value='수정' onclick="pupdate()">
    <input type='button' value='답변' onclick="reply()">
    <input type='button' value='삭제' onclick="pdel()">
  </DIV>
<br><br>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

