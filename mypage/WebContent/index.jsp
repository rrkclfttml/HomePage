<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
 
<!DOCTYPE html>
<html>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
<style>
/* Full height image header */
.bgimg-1 {
    background-position: center;
    background-size: cover;
    background-image: url("<%=root%>/imges/apple.jpg");
    min-height: 100%;
}
</style>
</head> 
<body>

<jsp:include page="/menu/top.jsp" flush="false"/>

<!-- Header with full-height image -->
<header class="bgimg-1 w3-display-container w3-grayscale-min" id="home">
  <div class="w3-display-left w3-text-white" style="padding:48px">
    <span class="w3-jumbo w3-hide-small">페이지에 오신 것을 환영합니다.</span><br>
    <span class="w3-xxlarge w3-hide-large w3-hide-medium">Start something that matters</span><br>
    <span class="w3-large">아직 제작 중 입니다.....ㅎㅎ</span>
    <p><a href="#about" class="w3-button w3-black w3-padding-large w3-large w3-margin-top w3-opacity w3-hover-opacity-off">
    			준비중..</a></p>
  </div> 
  <div class="w3-display-bottomleft w3-text-grey w3-large" style="padding:24px 48px">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
</header>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 

