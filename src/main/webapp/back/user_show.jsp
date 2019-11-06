<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#list").jqGrid({
            url : '${pageContext.request.contextPath}/user/findAllByRow?starId='+null,
            datatype : "json",
            colNames : [ '编号', '用户名', '密码','昵称', '手机号码','省份','城市','性别','创建时间'],
            colModel : [
                {name : 'id',hidden:true,editable:false,align:"center"},
                {name : 'username',editable:true,align:"center"},
                {name : 'password',editable:true,align:"center"},
                {name : 'nickname',editable:true,align:"center"},
                {name : 'phone',editable:true,align:"center"},
                {name : 'province',editable:true,align:"center"},
                {name : 'city',editable:true,align:"center"},
                {name : 'sex',editable:true,align:"center"},
                {name : 'createDate',align:"center"}
            ],
            height:400,
            autowidth:true,
            styleUI:"Bootstrap",
            rowNum : 5,
            rowList : [ 5,10,15 ],
            pager : '#pager',
            sortname : 'id',
            viewrecords : true,
            caption : "所有用户展示"
        }).navGrid("#pager", {edit : false,add : false,del : false,search:false});

    })



</script>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a href="#">所有文章</a></li>
    <li role="presentation"><a href="${pageContext.request.contextPath}/user/findAll"  >添加文章</a></li>
</ul>
<table id="list"></table>
<div id="pager" style="height: 40px"></div>

