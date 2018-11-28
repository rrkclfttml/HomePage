<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
 
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
 
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;
 
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<style type="text/css">
.title{
font-size: 28px;
	text-align: center;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 30%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/}

TABLE { /*태그 슬렉터*/
	margin: 0 auto; /* 테이블 가운데 정렬 */
	border-color: #AAAAAA; /* 테이블 외곽선 색깔 */
	border-width: 3px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
	
}

TH {
	border-color: #000000; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	color: #000000; /* 글자 색 */
	background-color: #FFFFFF; /* 배경 색 */
	padding: 10px; /* 셀 내부 간격 */
}

td {
	border-color: #000000; /* 테이블 외곽선 색깔 */
	border-width: 1px; /* 테이블 외곽선 두께 */
	border-style: solid; /* 테이블 외곽선 스타일 */
	color: #000000; /* 글자 색 */
	background-color: #FFFFFF; /* 배경 색 */
	padding: 5px; /* 셀 내부 간격 */
}

</style>

<script type="text/javascript">
function inputCheck(f){
	if(f.id.value==""){
		alert("아이디를 입력해주세요.");
		f.id.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value==""){
		alert("비밀번호확인을 입력해주세요.");
		f.repasswd.focus();
		return false;
	}
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다.");
		f.repasswd.focus();
		return false;
	}
	if(f.mname.value==""){
		alert("이름을 입력해주세요.");
		f.mname.focus();
		return false;
	}
	if(f.email.value==""){
		alert("이메일을 입력해주세요.");
		f.email.focus();
		return false;
	}
}

function idCheck(id){
	if(id==""){
		alert("아이디를 입력해주세요.");
		document.frm.id.focus();
	}else{
		var url="id_proc.jsp";
		url=url+"?id="+id;
		wr=window.open(url,"아이디 검색","width=500,height=500");
		wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);
	}
}

function emailCheck(email){
	if(email==""){
		alert("이메일을 입력해주세요.");
		document.frm.email.focus();
	}else{
		var url="email_proc.jsp";
		url=url+"?email="+email;
		wr = window.open(url,"이메일중복확인","width=500,height=500");
		wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);
	}
}

</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->

<br><br><br>

<DIV class="title">회원가입</DIV>
 
 <br><br>
<FORM name='frm' method='POST' action='./pcreateProc.jsp' 
	enctype="multipart/form-data"  onsubmit="return inputCheck(this)">
  <TABLE>
  
    <TR>
      <TH>사진</TH>
      <TD><input type="file" name="fname" ></TD>
      <td></td>
    </TR>
    <TR>
      <TH>*아이디</TH>
      <TD><input type="text" name="id" size="15">
      <input type="button" value="ID 중복확인" onclick="idCheck(document.frm.id.value)"></TD>
      <td>아이디를 적어주세요.</td>
    </TR>
    <TR>
      <TH>*비밀번호</TH>
      <TD><input type="password" name="passwd" size="15"></TD>
      <td>비밀번호를 입력해주세요.</td>
    </TR>
    <TR>
    <TR>
      <TH>*비밀번호 확인</TH>
      <TD><input type="password" name="repasswd" size="15"></TD>
      <td>비밀번호를 확인해주세요.</td>
    </TR>
    <TR>
      <TH>*이름</TH>
      <TD><input type="text" name="mname" size="15"></TD>
      <td>이름을 입력해주세요.</td>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><input type="text" name="tel" size="15"></TD>
      <TD></TD>
    </TR>
    <TR>
      <TH>*이메일</TH>
      <TD><input type="text" name="email" size="25">
      <input type="button" value="email중복확인" onclick="emailCheck(document.frm.email.value)"></td>
    <td>이메일을 적어주세요.</td>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><input type="text" name="address1" size="50" >
   
      	<br></br>
      <input type="text" name="address2" size="30"></TD>
      <TD></TD>
    </TR>
  </TABLE>
  
  <br>
  <DIV class='bottom' align="center">
    <input type='submit' value='회원가입'>
    <input type='button' value='취소' onclick="location.href='../menu/index.jsp'" >
  </DIV>
  <br>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

