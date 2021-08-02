<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SimpleDevops</title>

<spring:url value="/resources/core/css/hello.css" var="coreCss" />
<spring:url value="/resources/core/css/bootstrap.min.css" var="bootstrapCss" />
<spring:url value="/resources/core/images" var="images" />
<spring:url value="/resources/core/css/hello.js" var="coreJs" />
<spring:url value="/resources/core/css/bootstrap.min.js" var="bootstrapJs" />

<script src="${coreJs}"></script>
<script src="${bootstrapJs}"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<link href="${bootstrapCss}" rel="stylesheet" />
<link href="${coreCss}" rel="stylesheet" />
<script type="text/javascript" src="/resources/core/js/hello.js"></script>
</head>

<body onload=display_ct();>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">linux | github | jenkins | ansible | docker | k8s | promotheus </a>
		</div>
	</div>
</nav>

<div class="jumbotron">
	<div class="container">
		<h3>${title}</h3>
	</br>
		<h5>
			<c:if test="${not empty msg}">
				 ${msg}
			</c:if>
     </br></br>
			<c:if test="${empty msg}">
				Welcome Welcome!
			</c:if>
		<h5>
			<a href="<c:url value='/hello/Srini !!!' />" >Welcome</a>
		</p>
		<img src="${images}/devops.png" style="width:900px;height:250px;/></br>
	</div>

</div>
<div class="container">
	<div class="row">
		<div class="col-md-8"> </br></br></br></br></br>
			<h4>Srini Devops Lab, Hyd.</h4>
			<h5>Contact @ +91-9876543210</h5>
		</div>
	</div>
	<hr>
	<footer>
		<h5>&copy; Srini Labs 2021</h5>
		<h6 id='ct' style="text-align:right;"></h6>
	</footer>
</div>

</body>
</html>
