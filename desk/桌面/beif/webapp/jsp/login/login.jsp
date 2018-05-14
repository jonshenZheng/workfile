<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="../common/head_css.jsp"/>
    <title>登录</title>
    <link type="text/css" rel="stylesheet" href="${prc }/jsp/login/css/login.css">
</head>
<body class="login-bg">

    <div class="login-content">

        <div class="login-background-container">
            <div class="login-content-background">
            </div>
        </div>

        <div class="login-content-2">

            <!--中间内容-->
            <div class="y-row clearfix">
                <div class="login-title"><span>青岛白泽数据有限公司</span></div>

                <!--login-->
                <div class="login-module">
                    <div class="alibaba-login-iframe">
                        <div class="nc_voice">${error}</div>
                        <form id="loginForm" name="loginform" action="${prc}/login" method="post" >
                            <div id="login-content" class="form clearfix">
                                <!--用户名-->
                                <dl>
                                    <dt class="fm-label">
                                        <span class="icon-user"></span>
                                    </dt>
                                    <dd class="fm-field">
                                        <div class="fm-field-wrap">
                                            <input  class="fm-text" name="account" id="inputEmail3"  placeholder="账号" value="${account}" tabindex="1">
                                        </div>
                                    </dd>
                                </dl>

                                <!--密码-->
                                <dl>
                                    <dt class="fm-label">
                                        <span class="icon-password"></span>
                                    </dt>
                                    <dd  class="fm-field">
                                        <div class="fm-field-wrap">
                                        	<input  class="fm-text" type="password" name="passwordshow" style="visibility: hidden;opacity:0;">
                                            <input  class="fm-text" type="hidden" name="password"  id="realPw" placeholder="登录密码" >
                                        </div>
                                    </dd>
                                </dl>
                                <dl class="login-reloadValidateCode">
                                    <div class="fm-field-wrap">
                                        <span>
                                            <input type="text" name="validateCode" id="validateCode" placeholder="验证码" tabindex="3">
                                        </span>
                                        <img id="validateCodeImg" src="${prc}/validateCode"  class="validateCodeImg" onclick="reloadValidateCode();"/>
                                        <a onclick="reloadValidateCode();">看不清？</a>
                                    </div>
                                </dl>                               
                            </div>

                            <!--登录按钮-->
                            <div class="login-submit">
                                <a id='submitForm' class="fm-button fm-submit">登录</a>
                            </div>
                            <div class="infoArea clearfix" style="display: none">
                                <div class="fl">
                                    <input type="hidden" id="checkbox1" value="false" />
                                    <a class="remenberMe"><i></i>记住账号</a>
                                </div>
                                <div class="fr">
                                    <a href="">忘记密码</a>
                                </div>
                            </div>
                        </form>
                        <input  class="showPasswordInp" type="password" name="passwordshow"  id="inputPassword3" placeholder="登录密码" tabindex="2">
                    </div>
                </div>


            </div>
            <!--中间内容结束-->
        </div>


    </div>
    <!-- 版权信息 -->
    <div class="login-foot">
        <div class="login-foot-container">
            <p class="copyright">Copyright© 2017 青岛白泽数据有限公司 鲁ICP备17042679号-1</p>
        </div>
    </div>

    <jsp:include page="../common/footer_js.jsp" />
    <script src="${prc }/common/lib/md5/md5.min.js"></script>
    <script>
    
        $(function() {
            if (window.history && window.history.pushState) {
                $(window).on('popstate', function () {
                    //重新发请求
                    window.history.pushState('forward', null, '/');
                    window.history.forward(1);
                });
            }
            window.history.pushState('forward', null, '/'); //在IE中必须得有这两行
            window.history.forward(1);
            if(window.location.href!=top.location.href){
                var localObj = window.location;
                var contextPath = localObj.pathname.split("/")[1];
                var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
                window.open(basePath,'_top');
            }
        });
        //记住我
        var $remenberMe = $('.infoArea .remenberMe'),
            $remenberMe_ico = $remenberMe.find('i'),
            $remenberMe_inp = $('#checkbox1'); 

        $remenberMe.click(function(event) {
            if($remenberMe_ico.hasClass('active')){
                $remenberMe_ico.removeClass('active');
                $remenberMe_inp.val('none');
            }
            else{
                $remenberMe_ico.addClass('active');
                $remenberMe_inp.val('true');
            }
        });

        //submit
        var $loginform = $('#loginForm'),
            $submitBtn = $('#submitForm'),
            $account  = $('#inputEmail3'),
            $password = $('#inputPassword3'),
            $password_inp = $('#realPw');
        
        function loginFn(){
            
            var Vcode = $('#validateCode').val(),
                SALT = '-xDoB.zg8Ugf}',
                account =  $account.val(),
                password = $password.val();
    
            if(!account){
                //Popbox({msg:'账号不能为空',btnNum:1});
                alert('账号不能为空');
                return false;
            }
            else if(isChinese(account)){
                //Popbox({msg:'账号不能有中文',btnNum:1});
                alert('账号不能有中文');
                return false;
            }
    
            if(!password){
                //Popbox({msg:'密码不能为空',btnNum:1});
                alert('密码不能为空');
                return false;
            }
            
            if(!Vcode){
                alert('请输入验证码');
                return false;
            }
    
            password = md5(''+password+account+SALT);
    
            $password_inp.val(password);
    
            $loginform.submit();
            
        }

        $submitBtn.click(function(e) {
            loginFn();
        });
        function reloadValidateCode(){
            $("#validateCodeImg").attr("src","${prc}/validateCode?data=" + new Date() + Math.floor(Math.random()*24));
        }
        
        document.onkeydown = function(k){
            if(k.keyCode == 13){
                loginFn();
            }
        }
        
        
    </script>

</body>
</html>