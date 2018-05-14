<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="../common/head_css.jsp"/>
    <title>报价清单信息</title>
    <link rel="stylesheet" href="${prc }/common/css/offerList_mobile.css" />
    <style>

        .public-infoTab select{outline: none;}
        .public-infoTab .big-til,.public-infoTab .prodStyle,.public-infoTab .small-til{float:left;}
        .public-infoTab .prodStyle{width:159px;margin: 5px 5px 0 14px;}
        .public-infoTab .small-til{font-size: 12px;}
    </style>
</head>
<body style="background-color:#fff;">
<div id="bodyEl">
    <div class="topBox">
        <div class="cent clearfix">
            <h3>报价清单信息</h3>
            <a class="topBox-back"><i class="ico"></i><span>返回</span></a>
        </div>
    </div>
    <div class="wrapBox" style="background-color:#fff;">
        <div class="container-fluid">
            <form class="form-horizontal padding-t-30" role="form" action="${prc}/mOfferList/initOfferList" method="post" height="100%" onsubmit="return validateSubmit();">
                <input type="hidden" name="officeSpaceId" value="${officeSpaceId}">
                <div class="form-group">
                    <span style="float:left;font-weight: bold;padding-top: 3px;padding-left: 15px;">清单名称</span>
                    <div class="col-sm-3">
                        <p><input type="text" style="width:80%" id="offerListName" name="offerListName" value="${offerListName}" placeholder="请输入名字" required> <font color="red">*</font></p>
                    </div>
                </div>

                <div class="public-infoTab public-tabBox margin-b-20">
                    <div class="title"><span class="font-s-16 verticalAli-m" style="width:180px">客户企业信息</span><span class="padding-l-5 verticalAli-m fontSz-12">(填写后更能精准推荐对应的产品)</span></div>
                    <div class="clearfix tow-cols">
                        <div class="wp_box col-xs-6">
                            <dl>
                                <dt>企业类型：</dt>
                                <dd>
                                    <select class="select" name="companyType">
                                        <option value="0" selected="selected">请选择企业类型</option>
                                        <c:forEach items="${offerCompanyTypes}" var="type">
                                            <option value="${type.fid}">${type.name}</option>
                                        </c:forEach>
                                    </select>
                                </dd>
                            </dl>
                        </div>
                        <div class="wp_box col-xs-6">
                            <dl>
                                <dt>员工数：</dt>
                                <dd><input type="number" name="staffCount"  onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"><span class="danwei">人</span></dd>
                            </dl>
                        </div>
                        <div class="wp_box col-xs-6">
                            <dl>
                                <dt>用户面积：</dt>
                                <dd><input type="number" name="acreage" onkeyup="value=value.replace(/[^\d.]/g,'')"><span class="danwei">m²</span></dd>
                            </dl>
                        </div>
                        <div class="wp_box col-xs-6">
                            <dl>
                                <dt>总预算：</dt>
                                <dd><input type="number" name="budget" onkeyup="value=value.replace(/[^\d.]/g,'')"><span class="danwei">元</span></dd>
                            </dl>
                        </div>

                    </div>
                </div>

                <div class="public-infoTab public-tabBox margin-b-20" id="tabel-three-col">
                    <div class="title">
                        <span class="font-s-16 big-til">一键设置推荐方案</span>
                        <select name="" id="setStyleSelect" class="form-control prodStyle">
                            <option value="">请选择推荐方案</option>
                            <c:forEach items="${recommendTempls}" var="type">
                                <option value="${type.fid}">${type.name}</option>
                            </c:forEach>
                        </select>
                        <span class="small-til">（选择后，下面各区域均会选择同一推荐方案）</span>
                    </div>
                    <div class="clearfix tow-cols" id="setStyleSelectBox">
                        <c:forEach items="${areas}" var="area" varStatus="status">
                            <input type="hidden" name="areas[${status.index}].areaName" value="${area.areaName}">
                            <input type="hidden" name="areas[${status.index}].length" value="${area.length}">
                            <input type="hidden" name="areas[${status.index}].width" value="${area.width}">
                            <input type="hidden" name="areas[${status.index}].officeRoomId" value="${area.officeRoomId}">
                            <input type="hidden" name="areas[${status.index}].functionArea" value="${area.functionArea}">
                            <div class="wp_box col-xs-4">
                                <dl>
                                    <dt>${area.areaName }：</dt>
                                    <dd>
                                        <select class="select-sm" name="areas[${status.index}].recommendderTemplID">
                                            <option value="">请选择推荐方案</option>
                                            <c:forEach items="${area.recommendTempls}" var="type">
                                                <option class="${type.parentId}" value="${type.fid}" data-pid="${type.parentId}">${type.name}</option>
                                            </c:forEach>
                                        </select>
                                    </dd>
                                </dl>
                            </div>
                        </c:forEach>

                        <div class="wp_box col-lg-4 col-xs-4 blankbox">
                            <dl>
                                <dt></dt>
                                <dd>
                                </dd>
                            </dl>
                        </div>
                        <div class="wp_box col-lg-4 col-xs-4 blankbox">
                            <dl>
                                <dt></dt>
                                <dd>
                                </dd>
                            </dl>
                        </div>

                    </div>
                </div>

                <div class="textAli-r padding-b-50">
                    <button type="submit" class="btn btn-primary">开始报价</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

<jsp:include page="../common/footer_js.jsp" />
<script>


    var hei = screen.availHeight-26;
    $('#bodyEl').css({'height':hei+'px'});


    /*补全三列表格*/
    var $aotuTale = $('#tabel-three-col'),
        table_lis_len = $aotuTale.find('.wp_box').length-2,
        $spaceCol_el = $aotuTale.find('.blankbox'),
        table_type = table_lis_len%3;

    if(table_type===0){
        $spaceCol_el.hide();
    }
    else if(table_type === 2){
        $spaceCol_el.eq(1).hide();
    }

    /*一键设置风格*/
    var $setStyleSelect = $('#setStyleSelect'),
        $select_el = $('#setStyleSelectBox .select-sm'),
        temp,
        select_el_len = $select_el.length;

    $setStyleSelect.change(function(){
        var that = $(this),
            val = that.val(),
            selectTxt = that.find("option:selected").text();
        if( selectTxt !== '请选择推荐方案'){
            setSelectVal(val);
        }

    });

    function setSelectVal(val){
        temp = select_el_len;
        if(temp < 1){
            return;
        }
        for(;temp--;){
            //$select_el.eq(temp).find('option:contains('+val+')').attr("selected",'selected');
            $select_el.eq(temp).find('.'+val).attr("selected",true);
            //$select_el.eq(temp).val(val);
        }
    }
</script>
</html>